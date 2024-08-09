import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:routescom/core/errors/failures.dart';
import 'package:routescom/src/route_card/data/models/route_card_model.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';

abstract class RouteCardLocalDataSource {
  List<RouteCardModel> get getRouteCards;
  Future<bool> setRouteCard(RouteCard route);
  Future<bool> importRouteCard(String backupPath);
  Future<bool> exportRouteCard(int id, String backupPath);
  Future<bool> importAllRouteCards(String backupPath);
  Future<bool> exportAllRouteCards(String backupPath);
  Future<bool> deleteRouteCard(int id);
  Future<bool> deleteAllRouteCards();
}

class HiveRouteCardLocalDataSourceImpl implements RouteCardLocalDataSource {
  HiveRouteCardLocalDataSourceImpl() {
    Hive.initFlutter();
  }

  @override
  List<RouteCardModel> get getRouteCards {
    try {
      return Hive.box('routeCards')
          .values
          .map((route) => RouteCardModel.fromJson(route))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> setRouteCard(RouteCard route) async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      int nextID = 0;
      if (box.values.isNotEmpty) {
        nextID = RouteCardModel.fromJson(box.values.last).id + 1;
      }
      RouteCardModel newRoute = RouteCardModel.fromEntity(route).copyWith(id: route.id == 99999 ? nextID : route.id,);
      box.put(newRoute.id, newRoute.toJson());
      if (newRoute.parent != null && route.id == 99999) {
        updateParentCard(idParent: newRoute.parent!, idChild: newRoute.id, operation: 'add');
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  Future<void> updateParentCard({required int idParent, required int idChild, required String operation}) async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      RouteCardModel cardParent = RouteCardModel.fromJson(box.get(idParent));
      // RouteCardModel newCardParent = cardParent;
      if (operation == 'add') {
        cardParent = cardParent.copyWith(children: [...cardParent.children ?? [], idChild]);
      } else {
        cardParent.children!.remove(idChild);
      }
      box.put(idParent, cardParent.toJson());

    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> deleteRouteCard(int id) async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      // ELIMINACION DE TARJETA Y SUS HIJOS
      RouteCardModel routeCard = RouteCardModel.fromJson(box.get(id));
      if (routeCard.children!.isNotEmpty) {
        
        for (int i = routeCard.children!.length - 1; i >= 0; i--) {
          box.deleteAt(routeCard.children![i]);
        }
      }
      box.deleteAt(id);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> deleteAllRouteCards() async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      box.clear();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> exportRouteCard(int id, String backupPath) async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      Box<dynamic> backupBox = await Hive.openBox('backupRouteCards');
      // SE EXPORTA LA PLANTILLA
      // PRIMERO PASAMOS LA TARJETA Y SUS HIJAS AL BOX BACKUP
      RouteCardModel routeCard = RouteCardModel.fromJson(box.get(id));
      final boxPath = backupBox.path!;
      // SE GUARDAN LAS RUTAS
      _saveTemplate(id, box, backupBox);
      // SE CIERRA EL BOX BACKUP
      await backupBox.close();
      // SE REALIZA LA COPIA DE SEGURIDAD
      await _exportTemplate(cardTitle: routeCard.name, boxPath: boxPath, backupPath: backupPath);
      
      _clearBackupBox();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> exportAllRouteCards(String backupPath) async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      final boxPath = box.path!;
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      backupPath =
          '$backupPath/TARutas-${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year}-backup.hive';
      await File(boxPath).copy(backupPath);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> importRouteCard(String backupPath) async {
    print('IMPORT ROUTE CARD');
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      Box<dynamic> backupBox = await Hive.openBox('backupRouteCards');
      // final prefs = UserPreferences();
      final boxPath = backupBox.path!;
      print(boxPath);
      //await backupBox.close();
      // copy backup file
      File(backupPath).copy(boxPath);
      //box = await Hive.openBox('backupRouteCards');
      final parentCards = backupBox.values.where((card) => RouteCardModel.fromJson(card).parent == null);
      for (var parent in parentCards) {
        _loadTemplate(id: RouteCardModel.fromJson(parent).id);
      }
      _clearBackupBox();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  Future<void> _loadTemplate({required int id, int? parentId}) async {
    try {
      Box<dynamic> box = await Hive.openBox('routeCards');
      Box<dynamic> backupBox = await Hive.openBox('backupRouteCards');
      int newId = box.isNotEmpty ? box.values.last.id + 1 : 0;
      final RouteCardModel card = RouteCardModel.fromJson(backupBox.get(id));
      RouteCardModel restoredCard = RouteCardModel(
        id: newId,
        name: card.name,
        text: card.text,
        color: card.color,
        img: '',
        isGroup: card.isGroup,
        parent: parentId,
        children: card.children,
      );
      setRouteCard(restoredCard);

      if (card.children!.isNotEmpty) {
        for (int i = 0; i < card.children!.length; i++) {
          _loadTemplate(id: card.children![i], parentId: restoredCard.id);
        }
        // ACTUALIZO LA LISTA DE HIJOS EN PADRE
        List<int>? childrenID = [];
        List children = box.values
            .where((child) => child.parent == restoredCard.id)
            .toList();
        for (int i = 0; i < children.length; i++) {
          childrenID.add(children[i].id);
        }

        restoredCard = restoredCard.copyWith(children: childrenID);
        setRouteCard(restoredCard);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }

  @override
  Future<bool> importAllRouteCards(String backupPath) {
    // TODO: implement importAllRouteCards
    throw UnimplementedError();
  }

  void _saveTemplate(int id, Box<dynamic> box, Box<dynamic> backupBox) {
    RouteCardModel card = RouteCardModel.fromJson(box.get(id));
    print('SAVE ROUTECARD: ${card.name}');
    
    if (card.children!.isNotEmpty) {
      for (int i = card.children!.length - 1; i >= 0; i--) {
        _saveTemplate(card.children![i], box, backupBox);
      }
    }

    print('SAVE ROUTECARD: ${card.name}');
    backupBox.put(id, card.toJson());
  }

  Future<void> _exportTemplate(
      {required cardTitle,
      required String boxPath,
      required String backupPath}) async {
        print(boxPath);
        print(backupPath);
    try {
      
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      
      backupPath =
          '$backupPath/$cardTitle-${DateTime.now().day.toString().padLeft(2, '0')}${DateTime.now().month.toString().padLeft(2, '0')}${DateTime.now().year}-backup.hive';
      await File(boxPath).copy(backupPath);
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> _clearBackupBox() async {
    try {
      Box<dynamic> backupBox = await Hive.openBox('backupRouteCards');
      backupBox.clear();
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure(message: e.toString());
    }
  }
}

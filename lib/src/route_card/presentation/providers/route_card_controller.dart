import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routescom/src/route_card/application/services/route_card_service.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';

part 'route_card_controller.g.dart';

@riverpod
class RouteCardController extends _$RouteCardController {
  final RouteCardService service = RouteCardService();
  @override
  List<RouteCard> build() => service.getRouteCards;

  List<RouteCard> getRouteCards() => service.getRouteCards;

  Future<bool> setRouteCard({required RouteCard route}) async {
    final result = await service.setRouteCard(route);
    state = service.getRouteCards;
    return result;
  }

  Future<bool> deleteRouteCard({required int id}) async {
    final result = await service.deleteRouteCard(id);
    state = service.getRouteCards;
    return result;
  }

  Future<bool> deleteAllRouteCards() async {
    final result = await service.deleteAllRouteCards();
    state = []; 
    return result;
  }

  Future<bool> exportRouteCard({required int id, required String backupPath}) async {
    return await service.exportRouteCard(id, backupPath);
  }

  Future<bool> importRouteCard({required String backupPath}) async {
    final result = await service.importRouteCard(backupPath);
    state = service.getRouteCards;
    return result;
  }

  Future<bool> exportAllRouteCards({required String backupPath}) async {
    return await service.exportAllRouteCards(backupPath);
  }

  Future<bool> importAllRouteCards({required String backupPath}) async {
    final result = await service.importAllRouteCards(backupPath);
    state = service.getRouteCards;
    return result;
  }
}


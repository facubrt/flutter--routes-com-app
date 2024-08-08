import 'package:routescom/src/route_card/data/repositories/route_card_repository_impl.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';
import 'package:routescom/src/route_card/domain/repositories/route_card_repository.dart';

class RouteCardService {
  final RouteCardRepository repository = RouteCardRepositoryImpl();

  List<RouteCard> get getRouteCards {
    final result = repository.getRouteCards;
    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> setRouteCard(RouteCard route) async {
    final result = await repository.setRouteCard(route);

    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> deleteRouteCard(int id) async {
    final result = await repository.deleteRouteCard(id);

    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> deleteAllRouteCards() async {
    final result = await repository.deleteAllRouteCards();

    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> exportRouteCard(int id, String backupPath) async {
    final result = await repository.exportRouteCard(id, backupPath);

    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> importRouteCard(String backupPath) async {
    final result = await repository.importRouteCard(backupPath);

    return result.fold((l) => throw l, (r) => r); 
  }

  Future<bool> exportAllRouteCards(String backupPath) async {
    final result = await repository.exportAllRouteCards(backupPath);

    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> importAllRouteCards(String backupPath) async {
    final result = await repository.importAllRouteCards(backupPath);

    return result.fold((l) => throw l, (r) => r);
  }
}
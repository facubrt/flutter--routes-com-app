import 'package:dartz/dartz.dart';
import 'package:routescom/core/errors/failures.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';

abstract class RouteCardRepository {

  Either<Failure,List<RouteCard>> get getRouteCards;
  Future<Either<Failure, bool>> setRouteCard(RouteCard route);
  Future<Either<Failure, bool>> deleteRouteCard(int id);
  Future<Either<Failure, bool>> exportRouteCard(int id, String backupPath);
  Future<Either<Failure, bool>> importRouteCard(String backupPath);
  Future<Either<Failure, bool>> exportAllRouteCards(String backupPath);
  Future<Either<Failure, bool>> importAllRouteCards(String backupPath);
  Future<Either<Failure, bool>> deleteAllRouteCards();
  
}
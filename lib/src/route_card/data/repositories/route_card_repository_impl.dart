import 'package:dartz/dartz.dart';
import 'package:routescom/core/errors/failures.dart';
import 'package:routescom/src/route_card/data/data_sources/route_card_local_data_source.dart';
import 'package:routescom/src/route_card/domain/entities/route_card.dart';
import 'package:routescom/src/route_card/domain/repositories/route_card_repository.dart';

class RouteCardRepositoryImpl implements RouteCardRepository {
  final RouteCardLocalDataSource localDataSource =
      HiveRouteCardLocalDataSourceImpl();

  @override
  Either<Failure, List<RouteCard>> get getRouteCards {
    try {
      final List<RouteCard> result = localDataSource.getRouteCards;
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to get route cards'));
    }
  }

  @override
  Future<Either<Failure, bool>> setRouteCard(RouteCard route) async {
    try {
      final bool result = await localDataSource.setRouteCard(route);
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to set route card'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAllRouteCards() async {
    try {
      final bool result = await localDataSource.deleteAllRouteCards();
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to delete all route cards'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRouteCard(int id) async {
    try {
      final bool result = await localDataSource.deleteRouteCard(id);
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to delete route card'));
    }
  }

  @override
  Future<Either<Failure, bool>> exportAllRouteCards(String backupPath) async {
    try {
      final bool result = await localDataSource.exportAllRouteCards(backupPath);
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to export all route cards'));
    }
  }

  @override
  Future<Either<Failure, bool>> exportRouteCard(
      int id, String backupPath) async {
    try {
      final bool result = await localDataSource.exportRouteCard(id, backupPath);
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to export route card'));
    }
  }

  @override
  Future<Either<Failure, bool>> importAllRouteCards(String backupPath) async {
    try {
      final bool result = await localDataSource.importAllRouteCards(backupPath);
      return Right(result);
    } on LocalFailure {
      return Left(LocalFailure(message: 'Failed to import all route cards'));
    }
  }

  @override
  Future<Either<Failure, bool>> importRouteCard(String backupPath) async {
    try {
      final bool result = await localDataSource.importRouteCard(backupPath);
      return Right(result);
    } on LocalFailure {
      return Left(
        LocalFailure(message: 'Failed to import route card'),
      );
    }
  }
}

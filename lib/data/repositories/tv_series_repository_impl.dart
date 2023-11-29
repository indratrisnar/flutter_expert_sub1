import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:submission1/domain/entities/tv_series_detail_entity.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';
import 'package:submission1/common/exception.dart';
import 'package:submission1/common/failure.dart';

import '../../domain/repositories/tv_series_repository.dart';
import '../datasources/tv_series_local_data_source.dart';
import '../datasources/tv_series_remote_data_source.dart';
import '../models/tv_series_table.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TvSeriesEntity>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDataSource.getNowPlayingTv();
      return Right(result.map((model) => model.toEntity).toList());
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetailEntity>> getTvSeriesDetail(
      int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity);
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeriesEntity>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity).toList());
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeriesEntity>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity).toList());
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeriesEntity>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity).toList());
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeriesEntity>>> searchTvSeries(
      String query) async {
    try {
      final result = await remoteDataSource.searchTvs(query);
      return Right(result.map((model) => model.toEntity).toList());
    } on ServerException {
      return Left(ServerFailure('Server Error'));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetailEntity tv) async {
    try {
      final result =
          await localDataSource.insertWatchlist(TvSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvSeriesDetailEntity tv) async {
    try {
      final result =
          await localDataSource.removeWatchlist(TvSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeriesEntity>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}

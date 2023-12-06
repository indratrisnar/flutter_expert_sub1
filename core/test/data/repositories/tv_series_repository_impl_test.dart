import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockLocalDataSource extends Mock implements TvSeriesLocalDataSource {}

class MockRemoteDataSource extends Mock implements TvSeriesRemoteDataSource {}

void main() {
  late MockLocalDataSource mockLocalDataSource;
  late MockRemoteDataSource mockRemoteDataSource;
  late TvSeriesRepositoryImpl repositoryImpl;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    mockRemoteDataSource = MockRemoteDataSource();
    repositoryImpl = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('get now playing tv', () {
    test(
      'should return Right([TvSeries]) '
      'when remote datasource return data',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getNowPlayingTv(),
        ).thenAnswer((_) async => [testTvSeriesModel]);

        // act
        final result = await repositoryImpl.getNowPlayingTvSeries();

        // assert
        verify(() => mockRemoteDataSource.getNowPlayingTv());
        expect(result.isRight(), true);
        expect((result as Right).value, [testTvSeriesEntity]);
      },
    );

    test(
      'should return ServerFailure '
      'when remote datasource throw ServerException',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getNowPlayingTv(),
        ).thenThrow(ServerException());

        // act
        final result = await repositoryImpl.getNowPlayingTvSeries();

        // assert
        verify(() => mockRemoteDataSource.getNowPlayingTv());
        expect(result, const Left(ServerFailure('Server Error')));
      },
    );
  });

  group('get popular tv', () {
    test(
      'should return Right([TvSeries]) '
      'when remote datasource return data',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getPopularTv(),
        ).thenAnswer((_) async => [testTvSeriesModel]);

        // act
        final result = await repositoryImpl.getPopularTvSeries();

        // assert
        verify(() => mockRemoteDataSource.getPopularTv());
        expect(result.isRight(), true);
        expect((result as Right).value, [testTvSeriesEntity]);
      },
    );

    test(
      'should return ServerFailure '
      'when remote datasource throw ServerException',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getPopularTv(),
        ).thenThrow(ServerException());

        // act
        final result = await repositoryImpl.getPopularTvSeries();

        // assert
        verify(() => mockRemoteDataSource.getPopularTv());
        expect(result, const Left(ServerFailure('Server Error')));
      },
    );
  });

  group('get top rated tv', () {
    test(
      'should return Right([TvSeries]) '
      'when remote datasource return data',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTopRatedTv(),
        ).thenAnswer((_) async => [testTvSeriesModel]);

        // act
        final result = await repositoryImpl.getTopRatedTvSeries();

        // assert
        verify(() => mockRemoteDataSource.getTopRatedTv());
        expect(result.isRight(), true);
        expect((result as Right).value, [testTvSeriesEntity]);
      },
    );

    test(
      'should return ServerFailure '
      'when remote datasource throw ServerException',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTopRatedTv(),
        ).thenThrow(ServerException());

        // act
        final result = await repositoryImpl.getTopRatedTvSeries();

        // assert
        verify(() => mockRemoteDataSource.getTopRatedTv());
        expect(result, const Left(ServerFailure('Server Error')));
      },
    );
  });

  group('get detail tv', () {
    const tId = 1;
    test(
      'should return Right(TvSeriesDetail) '
      'when remote datasource return data',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTvDetail(any()),
        ).thenAnswer((_) async => testTvSeriesDetailModel);

        // act
        final result = await repositoryImpl.getTvSeriesDetail(tId);

        // assert
        verify(() => mockRemoteDataSource.getTvDetail(tId));
        expect(result, Right(testTvSeriesDetailEntity));
      },
    );

    test(
      'should return ServerFailure '
      'when remote datasource throw ServerException',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTvDetail(any()),
        ).thenThrow(ServerException());

        // act
        final result = await repositoryImpl.getTvSeriesDetail(tId);

        // assert
        verify(() => mockRemoteDataSource.getTvDetail(tId));
        expect(result, const Left(ServerFailure('Server Error')));
      },
    );
  });

  group('get recommendations tv', () {
    const tId = 1;
    test(
      'should return Right([TvSeries]) '
      'when remote datasource return data',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTvRecommendations(any()),
        ).thenAnswer((_) async => [testTvSeriesModel]);

        // act
        final result = await repositoryImpl.getTvSeriesRecommendations(tId);

        // assert
        verify(() => mockRemoteDataSource.getTvRecommendations(tId));
        expect(result.isRight(), true);
        expect((result as Right).value, [testTvSeriesEntity]);
      },
    );

    test(
      'should return ConnectionFailure '
      'when remote datasource throw SocketException',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTvRecommendations(any()),
        ).thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await repositoryImpl.getTvSeriesRecommendations(tId);

        // assert
        verify(() => mockRemoteDataSource.getTvRecommendations(tId));
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('search tv', () {
    const tQuery = 'Fal';
    test(
      'should return Right([TvSeries]) '
      'when remote datasource return data',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.searchTvs(any()),
        ).thenAnswer((_) async => [testTvSeriesModel]);

        // act
        final result = await repositoryImpl.searchTvSeries(tQuery);

        // assert
        verify(() => mockRemoteDataSource.searchTvs(tQuery));
        expect(result.isRight(), true);
        expect((result as Right).value, [testTvSeriesEntity]);
      },
    );

    test(
      'should return ConnectionFailure '
      'when remote datasource throw SocketException',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.searchTvs(any()),
        ).thenThrow(const SocketException('Failed to connect to the network'));

        // act
        final result = await repositoryImpl.searchTvSeries(tQuery);

        // assert
        verify(() => mockRemoteDataSource.searchTvs(tQuery));
        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('get watchlist tv', () {
    test(
      'should return Right([TvSeries]) '
      'when local datasource return data',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getWatchlistTv(),
        ).thenAnswer((_) async => [testTvSeriesTable]);

        // act
        final result = await repositoryImpl.getWatchlistTvSeries();

        // assert
        verify(() => mockLocalDataSource.getWatchlistTv());
        expect(result.isRight(), true);
        expect((result as Right).value, [testTvSeriesTable.toEntity()]);
      },
    );
  });

  group('check is add watchlist tv', () {
    const tId = 1;
    test(
      'should return true '
      'when local datasource return data',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getTvById(tId),
        ).thenAnswer((_) async => testTvSeriesTable);

        // act
        final result = await repositoryImpl.isAddedToWatchlist(tId);

        // assert
        verify(() => mockLocalDataSource.getTvById(tId));
        expect(result, true);
      },
    );

    test(
      'should return false '
      'when local datasource return null',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.getTvById(tId),
        ).thenAnswer((_) async => null);

        // act
        final result = await repositoryImpl.isAddedToWatchlist(tId);

        // assert
        verify(() => mockLocalDataSource.getTvById(tId));
        expect(result, false);
      },
    );
  });

  group('remove watchlist tv', () {
    const tvTable = testTvSeriesTable;
    test(
      'should return message success '
      'when local datasource return message',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.removeWatchlist(tvTable),
        ).thenAnswer((_) async => 'Removed from Watchlist');

        // act
        final result =
            await repositoryImpl.removeWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(() => mockLocalDataSource.removeWatchlist(tvTable));
        expect(result, const Right('Removed from Watchlist'));
      },
    );

    test(
      'should return Failure '
      'when local datasource throw database exception',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.removeWatchlist(tvTable),
        ).thenThrow(DatabaseException('Database Error'));

        // act
        final result =
            await repositoryImpl.removeWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(() => mockLocalDataSource.removeWatchlist(tvTable));
        expect(result, const Left(DatabaseFailure('Database Error')));
      },
    );
  });

  group('save watchlist tv', () {
    const tvTable = testTvSeriesTable;
    test(
      'should return message success '
      'when local datasource return message',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.insertWatchlist(tvTable),
        ).thenAnswer((_) async => 'Added to Watchlist');

        // act
        final result =
            await repositoryImpl.saveWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(() => mockLocalDataSource.insertWatchlist(tvTable));
        expect(result, const Right('Added to Watchlist'));
      },
    );

    test(
      'should return Failure '
      'when local datasource throw database exception',
      () async {
        // arrange
        when(
          () => mockLocalDataSource.insertWatchlist(tvTable),
        ).thenThrow(DatabaseException('Database Error'));

        // act
        final result =
            await repositoryImpl.saveWatchlist(testTvSeriesDetailEntity);

        // assert
        verify(() => mockLocalDataSource.insertWatchlist(tvTable));
        expect(result, const Left(DatabaseFailure('Database Error')));
      },
    );
  });
}

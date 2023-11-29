import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/common/exception.dart';
import 'package:submission1/data/datasources/db/tv_database_helper.dart';
import 'package:submission1/data/datasources/tv_series_local_data_source.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesDatabaseHelper extends Mock
    implements TvSeriesDatabaseHelper {}

void main() {
  late MockTvSeriesDatabaseHelper mockTvSeriesDatabaseHelper;
  late TvSeriesLocalDataSourceImpl localDataSourceImpl;

  setUp(() {
    mockTvSeriesDatabaseHelper = MockTvSeriesDatabaseHelper();
    localDataSourceImpl =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockTvSeriesDatabaseHelper);
    registerFallbackValue(testTvSeriesTable);
  });

  const testId = 1;

  group('get tv by id', () {
    test(
      'should return valid tv table when database success',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.getTvById(any()),
        ).thenAnswer(
          (_) async => testTvSeriesTableMap,
        );

        // act
        final result = await localDataSourceImpl.getTvById(testId);

        // assert
        verify(() => mockTvSeriesDatabaseHelper.getTvById(testId));
        expect(result, testTvSeriesTable);
      },
    );

    test(
      'should return null when not found',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.getTvById(any()),
        ).thenAnswer((_) async => null);

        // act
        final result = await localDataSourceImpl.getTvById(testId);

        // assert
        verify(() => mockTvSeriesDatabaseHelper.getTvById(testId));
        expect(result, null);
      },
    );
  });

  group('get watchlist tv', () {
    test(
      'should return list tv table when database success',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.getWatchlistTvs(),
        ).thenAnswer(
          (_) async => [testTvSeriesTableMap],
        );

        // act
        final result = await localDataSourceImpl.getWatchlistTv();

        // assert
        verify(() => mockTvSeriesDatabaseHelper.getWatchlistTvs());
        expect(result, [testTvSeriesTable]);
      },
    );

    test(
      'should return empty list when not found',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.getWatchlistTvs(),
        ).thenAnswer((_) async => []);

        // act
        final result = await localDataSourceImpl.getWatchlistTv();

        // assert
        verify(() => mockTvSeriesDatabaseHelper.getWatchlistTvs());
        expect(result, []);
      },
    );
  });

  group('save tv', () {
    test(
      'should return message success '
      'when database success',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.insertWatchlist(any()),
        ).thenAnswer((_) async => 1);

        // act
        final result =
            await localDataSourceImpl.insertWatchlist(testTvSeriesTable);

        // assert
        verify(() =>
            mockTvSeriesDatabaseHelper.insertWatchlist(testTvSeriesTable));
        expect(result, 'Added to Watchlist');
      },
    );

    test(
      'should throw [DatabaseException] '
      'when database failed',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.insertWatchlist(any()),
        ).thenThrow(DatabaseException('Failed add'));

        // act
        final result = localDataSourceImpl.insertWatchlist(testTvSeriesTable);

        // assert
        verify(() =>
            mockTvSeriesDatabaseHelper.insertWatchlist(testTvSeriesTable));
        expect(result, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove tv', () {
    test(
      'should return message success '
      'when database success',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.removeWatchlist(any()),
        ).thenAnswer((_) async => 1);

        // act
        final result =
            await localDataSourceImpl.removeWatchlist(testTvSeriesTable);

        // assert
        verify(() =>
            mockTvSeriesDatabaseHelper.removeWatchlist(testTvSeriesTable));
        expect(result, 'Removed from Watchlist');
      },
    );

    test(
      'should throw [DatabaseException] '
      'when database failed',
      () async {
        // arrange
        when(
          () => mockTvSeriesDatabaseHelper.removeWatchlist(any()),
        ).thenThrow(DatabaseException('Failed remove'));

        // act
        final result = localDataSourceImpl.removeWatchlist(testTvSeriesTable);

        // assert
        verify(() =>
            mockTvSeriesDatabaseHelper.removeWatchlist(testTvSeriesTable));
        expect(result, throwsA(isA<DatabaseException>()));
      },
    );
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission1/domain/repositories/tv_series_repository.dart';
import 'package:submission1/domain/usecases/get_now_playing_tv_series.dart';

import '../../dummy_data/dummy_tv_series.dart';

class MockTvSeriesRepository extends Mock implements TvSeriesRepository {}

void main() {
  late MockTvSeriesRepository mockTvSeriesRepository;
  late GetNowPlayingTvSeries usecase;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockTvSeriesRepository);
  });

  test(
    'should return list of [TvSeriesEntity] '
    'when repo success',
    () async {
      // arrange
      when(
        () => mockTvSeriesRepository.getNowPlayingTvSeries(),
      ).thenAnswer((_) async => Right(testTvSeriesList));

      // act
      final result = await usecase.execute();

      // assert
      verify(() => mockTvSeriesRepository.getNowPlayingTvSeries());
      expect(result, Right(testTvSeriesList));
    },
  );
}

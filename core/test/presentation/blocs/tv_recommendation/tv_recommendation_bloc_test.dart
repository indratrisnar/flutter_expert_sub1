import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetTvSeriesRecommendations extends Mock
    implements GetTvSeriesRecommendations {}

void main() {
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late TvRecommendationBloc bloc;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    bloc = TvRecommendationBloc(mockGetTvSeriesRecommendations);
  });

  const tId = 1;

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'emits [TvRecommendationLoading, TvRecommendationLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetTvSeriesRecommendations.execute(any()),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTvRecommendation(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationLoaded(testTvSeriesList),
    ],
  );
  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'emits [TvRecommendationLoading, TvRecommendationFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetTvSeriesRecommendations.execute(any()),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTvRecommendation(tId)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationFailure('Error'),
    ],
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc bloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    bloc = MovieRecommendationBloc(mockGetMovieRecommendations);
  });

  const tId = 1;
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emits [MovieRecommendationLoading, MovieRecommendationLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetMovieRecommendations.execute(any()),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetMovieRecommendation(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(testMovieList),
    ],
  );
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'emits [MovieRecommendationLoading, MovieRecommendationFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetMovieRecommendations.execute(any()),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetMovieRecommendation(tId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationFailure('Error'),
    ],
  );
}

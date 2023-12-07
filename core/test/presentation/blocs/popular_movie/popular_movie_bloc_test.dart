import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularMovie extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovie mockGetPopularMovie;
  late PopularMovieBloc bloc;

  setUp(() {
    mockGetPopularMovie = MockGetPopularMovie();
    bloc = PopularMovieBloc(mockGetPopularMovie);
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [PopularMovieLoading, PopularMovieLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetPopularMovie.execute(),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetPopularMovie()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieLoaded(testMovieList),
    ],
  );
  blocTest<PopularMovieBloc, PopularMovieState>(
    'emits [PopularMovieLoading, PopularMovieFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetPopularMovie.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetPopularMovie()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieFailure('Error'),
    ],
  );
}

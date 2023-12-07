import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emits [TopRatedMovieLoading, TopRatedMovieLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTopRatedMovie()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieLoaded(testMovieList),
    ],
  );
  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emits [TopRatedMovieLoading, TopRatedMovieFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTopRatedMovie()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieFailure('Error'),
    ],
  );
}

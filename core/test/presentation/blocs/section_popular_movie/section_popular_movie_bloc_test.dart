import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/presentation/blocs/section_popular_movie/section_popular_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late SectionPopularMovieBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = SectionPopularMovieBloc(mockGetPopularMovies);
  });

  blocTest<SectionPopularMovieBloc, SectionPopularMovieState>(
    'emits [SectionPopularMovieLoading, SectionPopularMovieLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetPopularMovies.execute(),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionPopularMovie()),
    expect: () => [
      SectionPopularMovieLoading(),
      SectionPopularMovieLoaded(testMovieList),
    ],
  );
  blocTest<SectionPopularMovieBloc, SectionPopularMovieState>(
    'emits [SectionPopularMovieLoading, SectionPopularMovieFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetPopularMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionPopularMovie()),
    expect: () => [
      SectionPopularMovieLoading(),
      SectionPopularMovieFailure('Error'),
    ],
  );
}

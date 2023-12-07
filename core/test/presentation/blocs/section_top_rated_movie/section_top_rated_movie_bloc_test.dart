import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/blocs/section_top_rated_movie/section_top_rated_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late SectionTopRatedMovieBloc bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = SectionTopRatedMovieBloc(mockGetTopRatedMovies);
  });

  blocTest<SectionTopRatedMovieBloc, SectionTopRatedMovieState>(
    'emits [SectionTopRatedMovieLoading, SectionTopRatedMovieLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionTopRatedMovie()),
    expect: () => [
      SectionTopRatedMovieLoading(),
      SectionTopRatedMovieLoaded(testMovieList),
    ],
  );
  blocTest<SectionTopRatedMovieBloc, SectionTopRatedMovieState>(
    'emits [SectionTopRatedMovieLoading, SectionTopRatedMovieFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetTopRatedMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionTopRatedMovie()),
    expect: () => [
      SectionTopRatedMovieLoading(),
      SectionTopRatedMovieFailure('Error'),
    ],
  );
}

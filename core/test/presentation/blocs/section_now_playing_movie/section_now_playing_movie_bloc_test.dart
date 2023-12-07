import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/presentation/blocs/section_now_playing_movie/section_now_playing_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetNowPlayingMovie extends Mock implements GetNowPlayingMovies {}

void main() {
  late MockGetNowPlayingMovie mockGetNowPlayingMovie;
  late SectionNowPlayingMovieBloc bloc;

  setUp(() {
    mockGetNowPlayingMovie = MockGetNowPlayingMovie();
    bloc = SectionNowPlayingMovieBloc(mockGetNowPlayingMovie);
  });

  blocTest<SectionNowPlayingMovieBloc, SectionNowPlayingMovieState>(
    'emits [SectionNowPlayingMovieLoading, SectionNowPlayingMovieLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetNowPlayingMovie.execute(),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionNowPlayingMovie()),
    expect: () => [
      SectionNowPlayingMovieLoading(),
      SectionNowPlayingMovieLoaded(testMovieList),
    ],
  );
  blocTest<SectionNowPlayingMovieBloc, SectionNowPlayingMovieState>(
    'emits [SectionNowPlayingMovieLoading, SectionNowPlayingMovieFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetNowPlayingMovie.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionNowPlayingMovie()),
    expect: () => [
      SectionNowPlayingMovieLoading(),
      SectionNowPlayingMovieFailure('Error'),
    ],
  );
}

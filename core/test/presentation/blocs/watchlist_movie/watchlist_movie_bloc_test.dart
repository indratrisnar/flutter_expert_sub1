import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/presentation/blocs/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieBloc bloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [WatchlistMovieLoading, WatchlistMovieLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetWatchlistMovies.execute(),
      ).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieLoaded(testMovieList),
    ],
  );
  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'emits [WatchlistMovieLoading, WatchlistMovieFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetWatchlistMovies.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieFailure('Error'),
    ],
  );
}

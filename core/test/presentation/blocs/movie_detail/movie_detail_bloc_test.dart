import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc bloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    bloc = MovieDetailBloc(mockGetMovieDetail);
  });

  const tId = 1;

  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailLoading, MovieDetailLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetMovieDetail.execute(any()),
      ).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailLoaded(testMovieDetail),
    ],
  );
  blocTest<MovieDetailBloc, MovieDetailState>(
    'emits [MovieDetailLoading, MovieDetailFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetMovieDetail.execute(any()),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetMovieDetail(tId)),
    expect: () => [
      MovieDetailLoading(),
      MovieDetailFailure('Error'),
    ],
  );
}

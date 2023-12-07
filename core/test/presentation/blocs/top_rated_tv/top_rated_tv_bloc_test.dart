import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/blocs/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetTopRatedTvSeries extends Mock implements GetTopRatedTvSeries {}

void main() {
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late TopRatedTvBloc bloc;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    bloc = TopRatedTvBloc(mockGetTopRatedTvSeries);
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'emits [TopRatedTvLoading, TopRatedTvLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetTopRatedTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTopRatedTv()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvLoaded(testTvSeriesList),
    ],
  );
  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'emits [TopRatedTvLoading, TopRatedTvFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetTopRatedTvSeries.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTopRatedTv()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvFailure('Error'),
    ],
  );
}

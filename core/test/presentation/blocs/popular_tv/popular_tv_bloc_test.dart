import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetPopularTv extends Mock implements GetPopularTvSeries {}

void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc bloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    bloc = PopularTvBloc(mockGetPopularTv);
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'emits [PopularTvLoading, PopularTvLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetPopularTv.execute(),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetPopularTv()),
    expect: () => [
      PopularTvLoading(),
      PopularTvLoaded(testTvSeriesList),
    ],
  );
  blocTest<PopularTvBloc, PopularTvState>(
    'emits [PopularTvLoading, PopularTvFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetPopularTv.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetPopularTv()),
    expect: () => [
      PopularTvLoading(),
      PopularTvFailure('Error'),
    ],
  );
}

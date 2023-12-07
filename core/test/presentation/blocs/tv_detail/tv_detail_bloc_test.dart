import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetTvSeriesDetail extends Mock implements GetTvSeriesDetail {}

void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvDetailBloc bloc;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    bloc = TvDetailBloc(mockGetTvSeriesDetail);
  });

  const tId = 1;

  blocTest<TvDetailBloc, TvDetailState>(
    'emits [TvDetailLoading, TvDetailLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetTvSeriesDetail.execute(any()),
      ).thenAnswer(
        (_) async => Right(testTvSeriesDetailEntity),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailLoaded(testTvSeriesDetailEntity),
    ],
  );
  blocTest<TvDetailBloc, TvDetailState>(
    'emits [TvDetailLoading, TvDetailFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetTvSeriesDetail.execute(any()),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailFailure('Error'),
    ],
  );
}

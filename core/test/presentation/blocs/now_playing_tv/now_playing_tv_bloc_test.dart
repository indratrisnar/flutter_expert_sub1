import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/presentation/blocs/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetNowPlayingTv extends Mock implements GetNowPlayingTvSeries {}

void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late NowPlayingTvBloc bloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    bloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'emits [NowPlayingTvLoading, NowPlayingTvLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetNowPlayingTv.execute(),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetNowPlayingTv()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvLoaded(testTvSeriesList),
    ],
  );
  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'emits [NowPlayingTvLoading, NowPlayingTvFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetNowPlayingTv.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetNowPlayingTv()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvFailure('Error'),
    ],
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/presentation/blocs/section_now_playing_tv/section_now_playing_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetNowPlayingTvSeries extends Mock implements GetNowPlayingTvSeries {}

void main() {
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late SectionNowPlayingTvBloc bloc;

  setUp(() {
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    bloc = SectionNowPlayingTvBloc(mockGetNowPlayingTvSeries);
  });

  blocTest<SectionNowPlayingTvBloc, SectionNowPlayingTvState>(
    'emits [SectionNowPlayingTvLoading, SectionNowPlayingTvLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetNowPlayingTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionNowPlayingTv()),
    expect: () => [
      SectionNowPlayingTvLoading(),
      SectionNowPlayingTvLoaded(testTvSeriesList),
    ],
  );
  blocTest<SectionNowPlayingTvBloc, SectionNowPlayingTvState>(
    'emits [SectionNowPlayingTvLoading, SectionNowPlayingTvFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetNowPlayingTvSeries.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionNowPlayingTv()),
    expect: () => [
      SectionNowPlayingTvLoading(),
      SectionNowPlayingTvFailure('Error'),
    ],
  );
}

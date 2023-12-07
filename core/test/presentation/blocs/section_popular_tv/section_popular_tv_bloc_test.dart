import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/presentation/blocs/section_popular_tv/section_popular_tv_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockGetPopularTvSeries extends Mock implements GetPopularTvSeries {}

void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late SectionPopularTvBloc bloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    bloc = SectionPopularTvBloc(mockGetPopularTvSeries);
  });

  blocTest<SectionPopularTvBloc, SectionPopularTvState>(
    'emits [SectionPopularTvLoading, SectionPopularTvLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionPopularTv()),
    expect: () => [
      SectionPopularTvLoading(),
      SectionPopularTvLoaded(testTvSeriesList),
    ],
  );
  blocTest<SectionPopularTvBloc, SectionPopularTvState>(
    'emits [SectionPopularTvLoading, SectionPopularTvFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockGetPopularTvSeries.execute(),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetSectionPopularTv()),
    expect: () => [
      SectionPopularTvLoading(),
      SectionPopularTvFailure('Error'),
    ],
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/search_tv_series.dart';
import 'package:core/presentation/blocs/tv_search/tv_search_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_tv_series.dart';

class MockSearchTvSeries extends Mock implements SearchTvSeries {}

void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late TvSearchBloc bloc;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    bloc = TvSearchBloc(mockSearchTvSeries);
  });

  const tId = 'tv';

  blocTest<TvSearchBloc, TvSearchState>(
    'emits [TvSearchLoading, TvSearchLoaded] '
    'when usecase success',
    build: () {
      when(
        () => mockSearchTvSeries.execute(any()),
      ).thenAnswer(
        (_) async => Right(testTvSeriesList),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTvSearch(tId)),
    expect: () => [
      TvSearchLoading(),
      TvSearchLoaded(testTvSeriesList),
    ],
  );
  blocTest<TvSearchBloc, TvSearchState>(
    'emits [TvSearchLoading, TvSearchFailure] '
    'when usecase failed',
    build: () {
      when(
        () => mockSearchTvSeries.execute(any()),
      ).thenAnswer(
        (_) async => const Left(ServerFailure('Error')),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(OnGetTvSearch(tId)),
    expect: () => [
      TvSearchLoading(),
      TvSearchFailure('Error'),
    ],
  );
}

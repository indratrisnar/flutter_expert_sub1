import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvSeries _searchTvSeries;
  TvSearchBloc(this._searchTvSeries) : super(TvSearchInitial()) {
    on<OnGetTvSearch>((event, emit) async {
      emit(TvSearchLoading());
      final result = await _searchTvSeries.execute(event.query);
      result.fold(
        (failure) => emit(TvSearchFailure(failure.message)),
        (data) => emit(TvSearchLoaded(data)),
      );
    });
  }
}

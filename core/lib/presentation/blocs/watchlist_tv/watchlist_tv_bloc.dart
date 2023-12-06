import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvSeries _getWatchlistTvSeries;
  WatchlistTvBloc(this._getWatchlistTvSeries) : super(WatchlistTvInitial()) {
    on<OnGetWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await _getWatchlistTvSeries.execute();
      result.fold(
        (failure) => emit(WatchlistTvFailure(failure.message)),
        (data) => emit(WatchlistTvLoaded(data)),
      );
    });
  }
}

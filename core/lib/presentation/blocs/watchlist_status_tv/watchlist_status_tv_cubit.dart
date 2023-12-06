import 'package:core/domain/entities/tv_series_detail_entity.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistStatusTvCubit extends Cubit<bool> {
  WatchlistStatusTvCubit(
    this._getWatchListStatusTvSeries,
    this._saveWatchlistTvSeries,
    this._removeWatchlistTvSeries,
  ) : super(false);

  final GetWatchListStatusTvSeries _getWatchListStatusTvSeries;
  final SaveWatchlistTvSeries _saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries _removeWatchlistTvSeries;

  Future checkWatchlist(int id) async {
    final result = await _getWatchListStatusTvSeries.execute(id);
    emit(result);
  }

  Future<List> tapButton(TvSeriesDetailEntity tv) async {
    try {
      if (!state) {
        return _add(tv);
      } else {
        return _remove(tv);
      }
    } finally {
      checkWatchlist(tv.id!);
    }
  }

  Future<List> _add(TvSeriesDetailEntity tv) async {
    final result = await _saveWatchlistTvSeries.execute(tv);
    if (result is Left) {
      return [false, ((result as Left).value as Failure).message];
    }
    return [true, (result as Right).value as String];
  }

  Future<List> _remove(TvSeriesDetailEntity tv) async {
    final result = await _removeWatchlistTvSeries.execute(tv);
    if (result is Left) {
      return [false, ((result as Left).value as Failure).message];
    }
    return [true, (result as Right).value as String];
  }
}

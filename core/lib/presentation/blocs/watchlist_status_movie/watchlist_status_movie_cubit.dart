import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistStatusMovieCubit extends Cubit<bool> {
  WatchlistStatusMovieCubit(
    this._getWatchListStatusMovie,
    this._saveWatchlistMovie,
    this._removeWatchlistMovie,
  ) : super(false);

  final GetWatchListStatus _getWatchListStatusMovie;
  final SaveWatchlist _saveWatchlistMovie;
  final RemoveWatchlist _removeWatchlistMovie;

  checkWatchlist(int id) async {
    final result = await _getWatchListStatusMovie.execute(id);
    emit(result);
  }

  Future<List> tapButton(MovieDetail movie) async {
    try {
      if (!state) {
        return _add(movie);
      } else {
        return _remove(movie);
      }
    } finally {
      checkWatchlist(movie.id);
    }
  }

  Future<List> _add(MovieDetail movie) async {
    final result = await _saveWatchlistMovie.execute(movie);
    if (result is Left) {
      return [false, ((result as Left).value as Failure).message];
    }
    return [true, (result as Right).value as String];
  }

  Future<List> _remove(MovieDetail movie) async {
    final result = await _removeWatchlistMovie.execute(movie);
    if (result is Left) {
      return [false, ((result as Left).value as Failure).message];
    }
    return [true, (result as Right).value as String];
  }
}

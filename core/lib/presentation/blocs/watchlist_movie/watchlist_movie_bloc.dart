import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(this._getWatchlistMovies)
      : super(WatchlistMovieInitial()) {
    on<OnGetWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(WatchlistMovieFailure(failure.message)),
        (data) => emit(WatchlistMovieLoaded(data)),
      );
    });
  }
}

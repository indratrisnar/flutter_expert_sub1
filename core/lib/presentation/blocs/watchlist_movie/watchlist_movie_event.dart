part of 'watchlist_movie_bloc.dart';

@immutable
sealed class WatchlistMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetWatchlistMovie extends WatchlistMovieEvent {}

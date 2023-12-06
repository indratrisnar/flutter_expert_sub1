part of 'watchlist_movie_bloc.dart';

@immutable
sealed class WatchlistMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> movies;

  WatchlistMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class WatchlistMovieFailure extends WatchlistMovieState {
  final String message;

  WatchlistMovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}

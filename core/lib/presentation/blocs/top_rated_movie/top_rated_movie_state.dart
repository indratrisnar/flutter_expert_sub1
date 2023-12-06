part of 'top_rated_movie_bloc.dart';

@immutable
sealed class TopRatedMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> movies;

  TopRatedMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class TopRatedMovieFailure extends TopRatedMovieState {
  final String message;

  TopRatedMovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}

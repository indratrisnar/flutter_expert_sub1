part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> movies;

  PopularMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class PopularMovieFailure extends PopularMovieState {
  final String message;

  PopularMovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}

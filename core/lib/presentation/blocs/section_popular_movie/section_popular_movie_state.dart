part of 'section_popular_movie_bloc.dart';

@immutable
sealed class SectionPopularMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SectionPopularMovieInitial extends SectionPopularMovieState {}

class SectionPopularMovieLoading extends SectionPopularMovieState {}

class SectionPopularMovieLoaded extends SectionPopularMovieState {
  final List<Movie> movies;

  SectionPopularMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class SectionPopularMovieFailure extends SectionPopularMovieState {
  final String message;

  SectionPopularMovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}

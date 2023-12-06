part of 'section_top_rated_movie_bloc.dart';

@immutable
sealed class SectionTopRatedMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SectionTopRatedMovieInitial extends SectionTopRatedMovieState {}

class SectionTopRatedMovieLoading extends SectionTopRatedMovieState {}

class SectionTopRatedMovieLoaded extends SectionTopRatedMovieState {
  final List<Movie> movie;

  SectionTopRatedMovieLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class SectionTopRatedMovieFailure extends SectionTopRatedMovieState {
  final String message;

  SectionTopRatedMovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}

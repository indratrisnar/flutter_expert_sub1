part of 'section_now_playing_movie_bloc.dart';

@immutable
sealed class SectionNowPlayingMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SectionNowPlayingMovieInitial extends SectionNowPlayingMovieState {}

class SectionNowPlayingMovieLoading extends SectionNowPlayingMovieState {}

class SectionNowPlayingMovieLoaded extends SectionNowPlayingMovieState {
  final List<Movie> movies;

  SectionNowPlayingMovieLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class SectionNowPlayingMovieFailure extends SectionNowPlayingMovieState {
  final String message;

  SectionNowPlayingMovieFailure(this.message);

  @override
  List<Object?> get props => [message];
}

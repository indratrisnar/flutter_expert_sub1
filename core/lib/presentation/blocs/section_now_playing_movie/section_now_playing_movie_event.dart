part of 'section_now_playing_movie_bloc.dart';

@immutable
sealed class SectionNowPlayingMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetSectionNowPlayingMovie extends SectionNowPlayingMovieEvent {}

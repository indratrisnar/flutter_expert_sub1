part of 'section_popular_movie_bloc.dart';

@immutable
sealed class SectionPopularMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetSectionPopularMovie extends SectionPopularMovieEvent {}

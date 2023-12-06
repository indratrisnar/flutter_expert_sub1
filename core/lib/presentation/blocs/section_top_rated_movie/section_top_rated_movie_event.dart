part of 'section_top_rated_movie_bloc.dart';

@immutable
sealed class SectionTopRatedMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetSectionTopRatedMovie extends SectionTopRatedMovieEvent {}

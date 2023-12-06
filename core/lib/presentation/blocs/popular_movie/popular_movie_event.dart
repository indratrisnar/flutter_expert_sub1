part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetPopularMovie extends PopularMovieEvent {}

part of 'top_rated_movie_bloc.dart';

@immutable
sealed class TopRatedMovieEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTopRatedMovie extends TopRatedMovieEvent {}

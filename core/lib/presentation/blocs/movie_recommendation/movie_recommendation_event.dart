part of 'movie_recommendation_bloc.dart';

@immutable
sealed class MovieRecommendationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  OnGetMovieRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}

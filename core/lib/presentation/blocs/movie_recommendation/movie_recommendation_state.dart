part of 'movie_recommendation_bloc.dart';

@immutable
sealed class MovieRecommendationState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieRecommendationInitial extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> movies;

  MovieRecommendationLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MovieRecommendationFailure extends MovieRecommendationState {
  final String message;

  MovieRecommendationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

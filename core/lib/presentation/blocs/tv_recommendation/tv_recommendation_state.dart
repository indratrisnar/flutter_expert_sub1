part of 'tv_recommendation_bloc.dart';

@immutable
sealed class TvRecommendationState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvRecommendationInitial extends TvRecommendationState {}

class TvRecommendationLoading extends TvRecommendationState {}

class TvRecommendationLoaded extends TvRecommendationState {
  final List<TvSeriesEntity> tvs;

  TvRecommendationLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class TvRecommendationFailure extends TvRecommendationState {
  final String message;

  TvRecommendationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

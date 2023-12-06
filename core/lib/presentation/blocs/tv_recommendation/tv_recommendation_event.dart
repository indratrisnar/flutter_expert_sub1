part of 'tv_recommendation_bloc.dart';

@immutable
sealed class TvRecommendationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTvRecommendation extends TvRecommendationEvent {
  final int id;

  OnGetTvRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}

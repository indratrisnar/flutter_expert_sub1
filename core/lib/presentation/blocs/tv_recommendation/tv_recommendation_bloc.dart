import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvSeriesRecommendations _getTvSeriesRecommendations;
  TvRecommendationBloc(this._getTvSeriesRecommendations)
      : super(TvRecommendationInitial()) {
    on<OnGetTvRecommendation>((event, emit) async {
      emit(TvRecommendationLoading());
      final result = await _getTvSeriesRecommendations.execute(event.id);
      result.fold(
        (failure) => emit(TvRecommendationFailure(failure.message)),
        (data) => emit(TvRecommendationLoaded(data)),
      );
    });
  }
}

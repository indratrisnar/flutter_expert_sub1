import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendations;
  MovieRecommendationBloc(this._getMovieRecommendations)
      : super(MovieRecommendationInitial()) {
    on<OnGetMovieRecommendation>((event, emit) async {
      emit(MovieRecommendationLoading());
      final result = await _getMovieRecommendations.execute(event.id);
      result.fold(
        (failure) => emit(MovieRecommendationFailure(failure.message)),
        (data) => emit(MovieRecommendationLoaded(data)),
      );
    });
  }
}

import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovie;
  TopRatedMovieBloc(this._getTopRatedMovie) : super(TopRatedMovieInitial()) {
    on<OnGetTopRatedMovie>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovie.execute();
      result.fold(
        (failure) => emit(TopRatedMovieFailure(failure.message)),
        (data) => emit(TopRatedMovieLoaded(data)),
      );
    });
  }
}

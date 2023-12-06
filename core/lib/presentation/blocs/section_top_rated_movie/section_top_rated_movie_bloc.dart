import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_top_rated_movie_event.dart';
part 'section_top_rated_movie_state.dart';

class SectionTopRatedMovieBloc
    extends Bloc<SectionTopRatedMovieEvent, SectionTopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;
  SectionTopRatedMovieBloc(this._getTopRatedMovies)
      : super(SectionTopRatedMovieInitial()) {
    on<OnGetSectionTopRatedMovie>((event, emit) async {
      emit(SectionTopRatedMovieLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(SectionTopRatedMovieFailure(failure.message)),
        (data) => emit(SectionTopRatedMovieLoaded(data)),
      );
    });
  }
}

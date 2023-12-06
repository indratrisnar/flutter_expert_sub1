import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_popular_movie_event.dart';
part 'section_popular_movie_state.dart';

class SectionPopularMovieBloc
    extends Bloc<SectionPopularMovieEvent, SectionPopularMovieState> {
  final GetPopularMovies _getPopularMovies;
  SectionPopularMovieBloc(this._getPopularMovies)
      : super(SectionPopularMovieInitial()) {
    on<OnGetSectionPopularMovie>((event, emit) async {
      emit(SectionPopularMovieLoading());
      final result = await _getPopularMovies.execute();
      result.fold(
        (failure) => emit(SectionPopularMovieFailure(failure.message)),
        (data) => emit(SectionPopularMovieLoaded(data)),
      );
    });
  }
}

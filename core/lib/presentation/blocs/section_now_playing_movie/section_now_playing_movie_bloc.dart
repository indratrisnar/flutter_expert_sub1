import 'package:core/domain/entities/movie.dart';

import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_now_playing_movie_event.dart';
part 'section_now_playing_movie_state.dart';

class SectionNowPlayingMovieBloc
    extends Bloc<SectionNowPlayingMovieEvent, SectionNowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  SectionNowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(SectionNowPlayingMovieInitial()) {
    on<OnGetSectionNowPlayingMovie>((event, emit) async {
      emit(SectionNowPlayingMovieLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(SectionNowPlayingMovieFailure(failure.message)),
        (data) => emit(SectionNowPlayingMovieLoaded(data)),
      );
    });
  }
}

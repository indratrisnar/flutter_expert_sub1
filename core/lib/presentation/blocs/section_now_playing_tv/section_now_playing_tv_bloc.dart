import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_now_playing_tv_event.dart';
part 'section_now_playing_tv_state.dart';

class SectionNowPlayingTvBloc
    extends Bloc<SectionNowPlayingTvEvent, SectionNowPlayingTvState> {
  final GetNowPlayingTvSeries _getSectionNowPlayingTvSeries;
  SectionNowPlayingTvBloc(this._getSectionNowPlayingTvSeries)
      : super(SectionNowPlayingTvInitial()) {
    on<OnGetSectionNowPlayingTv>((event, emit) async {
      emit(SectionNowPlayingTvLoading());
      final result = await _getSectionNowPlayingTvSeries.execute();
      result.fold(
        (failure) => emit(SectionNowPlayingTvFailure(failure.message)),
        (data) => emit(SectionNowPlayingTvLoaded(data)),
      );
    });
  }
}

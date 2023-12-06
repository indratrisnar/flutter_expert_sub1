import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTvSeries _getNowPlayingTvSeries;
  NowPlayingTvBloc(this._getNowPlayingTvSeries) : super(NowPlayingTvInitial()) {
    on<OnGetNowPlayingTv>((event, emit) async {
      emit(NowPlayingTvLoading());
      final result = await _getNowPlayingTvSeries.execute();
      result.fold(
        (failure) => emit(NowPlayingTvFailure(failure.message)),
        (data) => emit(NowPlayingTvLoaded(data)),
      );
    });
  }
}

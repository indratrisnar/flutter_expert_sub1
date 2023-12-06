import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvSeries _getTopRatedTvSeries;
  TopRatedTvBloc(this._getTopRatedTvSeries) : super(TopRatedTvInitial()) {
    on<OnGetTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await _getTopRatedTvSeries.execute();
      result.fold(
        (failure) => emit(TopRatedTvFailure(failure.message)),
        (data) => emit(TopRatedTvLoaded(data)),
      );
    });
  }
}

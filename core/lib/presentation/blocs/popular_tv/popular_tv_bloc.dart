import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries _getPopularTvSeries;
  PopularTvBloc(this._getPopularTvSeries) : super(PopularTvInitial()) {
    on<OnGetPopularTv>((event, emit) async {
      emit(PopularTvLoading());
      final result = await _getPopularTvSeries.execute();
      result.fold(
        (failure) => emit(PopularTvFailure(failure.message)),
        (data) => emit(PopularTvLoaded(data)),
      );
    });
  }
}

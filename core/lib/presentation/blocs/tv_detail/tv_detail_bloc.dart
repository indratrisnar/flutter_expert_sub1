import 'package:core/domain/entities/tv_series_detail_entity.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvSeriesDetail _getTvSeriesDetail;
  TvDetailBloc(this._getTvSeriesDetail) : super(TvDetailInitial()) {
    on<OnGetTvDetail>((event, emit) async {
      emit(TvDetailLoading());
      final result = await _getTvSeriesDetail.execute(event.id);
      result.fold(
        (failure) => emit(TvDetailFailure(failure.message)),
        (data) => emit(TvDetailLoaded(data)),
      );
    });
  }
}

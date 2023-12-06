import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_top_rated_tv_event.dart';
part 'section_top_rated_tv_state.dart';

class SectionTopRatedTvBloc
    extends Bloc<SectionTopRatedTvEvent, SectionTopRatedTvState> {
  final GetTopRatedTvSeries _getSectionTopRatedTvSeries;
  SectionTopRatedTvBloc(this._getSectionTopRatedTvSeries)
      : super(SectionTopRatedTvInitial()) {
    on<OnGetSectionTopRatedTv>((event, emit) async {
      emit(SectionTopRatedTvLoading());
      final result = await _getSectionTopRatedTvSeries.execute();
      result.fold(
        (failure) => emit(SectionTopRatedTvFailure(failure.message)),
        (data) => emit(SectionTopRatedTvLoaded(data)),
      );
    });
  }
}

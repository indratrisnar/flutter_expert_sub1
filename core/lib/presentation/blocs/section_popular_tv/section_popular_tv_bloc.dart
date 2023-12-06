import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'section_popular_tv_event.dart';
part 'section_popular_tv_state.dart';

class SectionPopularTvBloc
    extends Bloc<SectionPopularTvEvent, SectionPopularTvState> {
  final GetPopularTvSeries _getSectionPopularTvSeries;
  SectionPopularTvBloc(this._getSectionPopularTvSeries)
      : super(SectionPopularTvInitial()) {
    on<OnGetSectionPopularTv>((event, emit) async {
      emit(SectionPopularTvLoading());
      final result = await _getSectionPopularTvSeries.execute();
      result.fold(
        (failure) => emit(SectionPopularTvFailure(failure.message)),
        (data) => emit(SectionPopularTvLoaded(data)),
      );
    });
  }
}

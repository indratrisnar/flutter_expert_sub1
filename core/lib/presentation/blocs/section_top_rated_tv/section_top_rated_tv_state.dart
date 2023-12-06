part of 'section_top_rated_tv_bloc.dart';

@immutable
sealed class SectionTopRatedTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SectionTopRatedTvInitial extends SectionTopRatedTvState {}

class SectionTopRatedTvLoading extends SectionTopRatedTvState {}

class SectionTopRatedTvLoaded extends SectionTopRatedTvState {
  final List<TvSeriesEntity> tvs;

  SectionTopRatedTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class SectionTopRatedTvFailure extends SectionTopRatedTvState {
  final String message;

  SectionTopRatedTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

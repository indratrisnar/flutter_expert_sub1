part of 'section_popular_tv_bloc.dart';

@immutable
sealed class SectionPopularTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SectionPopularTvInitial extends SectionPopularTvState {}

class SectionPopularTvLoading extends SectionPopularTvState {}

class SectionPopularTvLoaded extends SectionPopularTvState {
  final List<TvSeriesEntity> tvs;

  SectionPopularTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class SectionPopularTvFailure extends SectionPopularTvState {
  final String message;

  SectionPopularTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

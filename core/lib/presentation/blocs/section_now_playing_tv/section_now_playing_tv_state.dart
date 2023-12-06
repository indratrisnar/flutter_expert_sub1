part of 'section_now_playing_tv_bloc.dart';

@immutable
sealed class SectionNowPlayingTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SectionNowPlayingTvInitial extends SectionNowPlayingTvState {}

class SectionNowPlayingTvLoading extends SectionNowPlayingTvState {}

class SectionNowPlayingTvLoaded extends SectionNowPlayingTvState {
  final List<TvSeriesEntity> tvs;

  SectionNowPlayingTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class SectionNowPlayingTvFailure extends SectionNowPlayingTvState {
  final String message;

  SectionNowPlayingTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

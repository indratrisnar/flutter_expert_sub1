part of 'now_playing_tv_bloc.dart';

@immutable
sealed class NowPlayingTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class NowPlayingTvInitial extends NowPlayingTvState {}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<TvSeriesEntity> tvs;

  NowPlayingTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class NowPlayingTvFailure extends NowPlayingTvState {
  final String message;

  NowPlayingTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

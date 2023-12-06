part of 'now_playing_tv_bloc.dart';

@immutable
sealed class NowPlayingTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetNowPlayingTv extends NowPlayingTvEvent {}

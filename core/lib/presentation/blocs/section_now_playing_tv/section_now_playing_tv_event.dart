part of 'section_now_playing_tv_bloc.dart';

@immutable
sealed class SectionNowPlayingTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetSectionNowPlayingTv extends SectionNowPlayingTvEvent {}

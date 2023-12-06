part of 'watchlist_tv_bloc.dart';

@immutable
sealed class WatchlistTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetWatchlistTv extends WatchlistTvEvent {}

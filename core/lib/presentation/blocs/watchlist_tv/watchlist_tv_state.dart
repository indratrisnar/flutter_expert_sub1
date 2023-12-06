part of 'watchlist_tv_bloc.dart';

@immutable
sealed class WatchlistTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvLoaded extends WatchlistTvState {
  final List<TvSeriesEntity> tvs;

  WatchlistTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class WatchlistTvFailure extends WatchlistTvState {
  final String message;

  WatchlistTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

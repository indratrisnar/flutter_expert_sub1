part of 'top_rated_tv_bloc.dart';

@immutable
sealed class TopRatedTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<TvSeriesEntity> tvs;

  TopRatedTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class TopRatedTvFailure extends TopRatedTvState {
  final String message;

  TopRatedTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

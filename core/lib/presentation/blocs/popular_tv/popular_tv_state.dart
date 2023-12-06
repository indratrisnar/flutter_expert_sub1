part of 'popular_tv_bloc.dart';

@immutable
sealed class PopularTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PopularTvInitial extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<TvSeriesEntity> tvs;

  PopularTvLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class PopularTvFailure extends PopularTvState {
  final String message;

  PopularTvFailure(this.message);

  @override
  List<Object?> get props => [message];
}

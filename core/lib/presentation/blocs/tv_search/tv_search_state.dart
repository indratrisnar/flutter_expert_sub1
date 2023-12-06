part of 'tv_search_bloc.dart';

@immutable
sealed class TvSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvSearchInitial extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchLoaded extends TvSearchState {
  final List<TvSeriesEntity> tvs;

  TvSearchLoaded(this.tvs);

  @override
  List<Object?> get props => [tvs];
}

class TvSearchFailure extends TvSearchState {
  final String message;

  TvSearchFailure(this.message);

  @override
  List<Object?> get props => [message];
}

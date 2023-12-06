part of 'tv_detail_bloc.dart';

@immutable
sealed class TvDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvSeriesDetailEntity tv;

  TvDetailLoaded(this.tv);

  @override
  List<Object?> get props => [tv];
}

class TvDetailFailure extends TvDetailState {
  final String message;

  TvDetailFailure(this.message);

  @override
  List<Object?> get props => [message];
}

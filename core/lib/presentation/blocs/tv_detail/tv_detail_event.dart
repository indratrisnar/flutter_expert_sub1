part of 'tv_detail_bloc.dart';

@immutable
sealed class TvDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTvDetail extends TvDetailEvent {
  final int id;

  OnGetTvDetail(this.id);

  @override
  List<Object?> get props => [id];
}

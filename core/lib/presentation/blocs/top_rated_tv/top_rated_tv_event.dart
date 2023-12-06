part of 'top_rated_tv_bloc.dart';

@immutable
sealed class TopRatedTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTopRatedTv extends TopRatedTvEvent {}

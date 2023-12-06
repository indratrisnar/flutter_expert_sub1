part of 'popular_tv_bloc.dart';

@immutable
sealed class PopularTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetPopularTv extends PopularTvEvent {}

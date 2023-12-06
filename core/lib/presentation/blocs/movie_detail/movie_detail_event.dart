part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetMovieDetail extends MovieDetailEvent {
  final int id;

  OnGetMovieDetail(this.id);

  @override
  List<Object?> get props => [id];
}

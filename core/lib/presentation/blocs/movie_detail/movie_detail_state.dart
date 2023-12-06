part of 'movie_detail_bloc.dart';

@immutable
sealed class MovieDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailLoaded(this.movie);

  @override
  List<Object?> get props => [movie];
}

class MovieDetailFailure extends MovieDetailState {
  final String message;

  MovieDetailFailure(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:dartz/dartz.dart';
import 'package:submission1/domain/entities/movie.dart';
import 'package:submission1/domain/repositories/movie_repository.dart';
import 'package:submission1/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}

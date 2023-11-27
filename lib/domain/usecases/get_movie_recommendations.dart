import 'package:dartz/dartz.dart';
import 'package:submission1/domain/entities/movie.dart';
import 'package:submission1/domain/repositories/movie_repository.dart';
import 'package:submission1/common/failure.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}

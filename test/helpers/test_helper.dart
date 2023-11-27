import 'package:submission1/data/datasources/db/database_helper.dart';
import 'package:submission1/data/datasources/movie_local_data_source.dart';
import 'package:submission1/data/datasources/movie_remote_data_source.dart';
import 'package:submission1/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

import 'dart:convert';
import 'dart:io';

import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseURL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Movies', () {
    var dir = Directory.current.path;
    final String jsonString = File(
      '$dir/test/data/datasources/now_playing_new.json',
    ).readAsStringSync();
    final tMovieList =
        MovieResponse.fromJson(json.decode(jsonString)).movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.getNowPlayingMovies();
      // assert
      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    var dir = Directory.current.path;
    final String jsonString = File(
      '$dir/test/data/datasources/popular_new.json',
    ).readAsStringSync();
    final tMovieList =
        MovieResponse.fromJson(json.decode(jsonString)).movieList;

    test('should return list of movies when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.getPopularMovies();
      // assert
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    var dir = Directory.current.path;
    final String jsonString = File(
      '$dir/test/data/datasources/top_rated_new.json',
    ).readAsStringSync();
    final tMovieList =
        MovieResponse.fromJson(json.decode(jsonString)).movieList;

    test('should return list of movies when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.getTopRatedMovies();
      // assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedMovies();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    var dir = Directory.current.path;
    final String jsonString = File(
      '$dir/test/data/datasources/movie_detail_new.json',
    ).readAsStringSync();
    final tMovieDetail = MovieDetailResponse.fromJson(json.decode(jsonString));

    test('should return movie detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.getMovieDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseURL/movie/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    var dir = Directory.current.path;
    final String jsonString = File(
      '$dir/test/data/datasources/movie_recommendations_new.json',
    ).readAsStringSync();
    final tMovieList =
        MovieResponse.fromJson(json.decode(jsonString)).movieList;
    const tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.getMovieRecommendations(tId);
      // assert
      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getMovieRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    var dir = Directory.current.path;
    final String jsonString = File(
      '$dir/test/data/datasources/search_spiderman_movie_new.json',
    ).readAsStringSync();
    final tSearchResult =
        MovieResponse.fromJson(json.decode(jsonString)).movieList;
    const tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await dataSource.searchMovies(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseURL/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchMovies(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}

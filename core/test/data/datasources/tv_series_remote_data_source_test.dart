import 'dart:convert';

import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/io_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:core/data/models/tv_response.dart';
import 'package:core/data/models/tv_series_detail_model.dart';
import 'package:core/data/models/tv_series_model.dart';

import '../../json_reader.dart';

class MockClient extends Mock implements IOClient {}

void main() {
  late MockClient mockHttpClient;
  late TvSeriesRemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockClient();
    remoteDataSourceImpl = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri());
  });

  group('get now playing', () {
    String tResponse = readJson('dummy_data/now_playing_tv_series.json');
    List<TvSeriesModel> tvs = TvResponse.fromJson(jsonDecode(tResponse)).list;

    test(
      'should return list of [TvSeriesModel] '
      'when response status code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );

        // act
        final result = await remoteDataSourceImpl.getNowPlayingTv();

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/on_the_air?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(result, tvs);
      },
    );

    test(
      'should throw [ServerException] '
      'when response status code is not 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response('Server Error', 500),
        );

        // act
        final call = remoteDataSourceImpl.getNowPlayingTv();

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/on_the_air?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get popular tv', () {
    String tResponse = readJson('dummy_data/popular_tv_series.json');
    List<TvSeriesModel> tvs = TvResponse.fromJson(jsonDecode(tResponse)).list;

    test(
      'should return list of [TvSeriesModel] '
      'when response status code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );

        // act
        final result = await remoteDataSourceImpl.getPopularTv();

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/popular?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(result, tvs);
      },
    );

    test(
      'should throw [ServerException] '
      'when response status code is not 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response('Server Error', 500),
        );

        // act
        final call = remoteDataSourceImpl.getPopularTv();

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/popular?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get top rated tv', () {
    String tResponse = readJson('dummy_data/top_rated_tv_series.json');
    List<TvSeriesModel> tvs = TvResponse.fromJson(jsonDecode(tResponse)).list;

    test(
      'should return list of [TvSeriesModel] '
      'when response status code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );

        // act
        final result = await remoteDataSourceImpl.getTopRatedTv();

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/top_rated?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(result, tvs);
      },
    );

    test(
      'should throw [ServerException] '
      'when response status code is not 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response('Server Error', 500),
        );

        // act
        final call = remoteDataSourceImpl.getTopRatedTv();

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/top_rated?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv detail', () {
    String tResponse = readJson('dummy_data/tv_series_detail.json');
    TvSeriesDetailModel detail = TvSeriesDetailModel.fromJson(
      Map.from(jsonDecode(tResponse)),
    );
    const tId = 1;

    test(
      'should return [TvSeriesDetailModel] '
      'when response status code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );

        // act
        final result = await remoteDataSourceImpl.getTvDetail(tId);

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/$tId?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(result, detail);
      },
    );

    test(
      'should throw [ServerException] '
      'when response status code is not 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response('Server Error', 500),
        );

        // act
        final call = remoteDataSourceImpl.getTvDetail(tId);

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/$tId?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get tv recommendations', () {
    String tResponse = readJson('dummy_data/tv_series_recommendations.json');
    List<TvSeriesModel> tvs = TvResponse.fromJson(jsonDecode(tResponse)).list;
    const tId = 1;

    test(
      'should return list of [TvSeriesModel] '
      'when response status code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );

        // act
        final result = await remoteDataSourceImpl.getTvRecommendations(tId);

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/$tId/recommendations?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(result, tvs);
      },
    );

    test(
      'should throw [ServerException] '
      'when response status code is not 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response('Server Error', 500),
        );

        // act
        final call = remoteDataSourceImpl.getTvRecommendations(tId);

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/tv/$tId/recommendations?${TvSeriesRemoteDataSourceImpl.apiKey}',
        );
        verify(() => mockHttpClient.get(url));
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search tv', () {
    String tResponse = readJson('dummy_data/search_tv_series.json');
    List<TvSeriesModel> tvs = TvResponse.fromJson(jsonDecode(tResponse)).list;
    const tQuery = 'Fal';

    test(
      'should return list of [TvSeriesModel] '
      'when response status code is 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );

        // act
        final result = await remoteDataSourceImpl.searchTvs(tQuery);

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/search/tv?${TvSeriesRemoteDataSourceImpl.apiKey}&query=$tQuery',
        );
        verify(() => mockHttpClient.get(url));
        expect(result, tvs);
      },
    );

    test(
      'should throw [ServerException] '
      'when response status code is not 200',
      () async {
        // arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer(
          (_) async => http.Response('Server Error', 500),
        );

        // act
        final call = remoteDataSourceImpl.searchTvs(tQuery);

        // assert
        Uri url = Uri.parse(
          '${TvSeriesRemoteDataSourceImpl.baseURL}/search/tv?${TvSeriesRemoteDataSourceImpl.apiKey}&query=$tQuery',
        );
        verify(() => mockHttpClient.get(url));
        expect(call, throwsA(isA<ServerException>()));
      },
    );
  });
}

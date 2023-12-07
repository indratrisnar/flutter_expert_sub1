import 'dart:io';

import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/tv_database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:core/domain/usecases/search_tv_series.dart';
import 'package:core/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/presentation/blocs/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:core/presentation/blocs/section_now_playing_movie/section_now_playing_movie_bloc.dart';
import 'package:core/presentation/blocs/section_now_playing_tv/section_now_playing_tv_bloc.dart';
import 'package:core/presentation/blocs/section_popular_movie/section_popular_movie_bloc.dart';
import 'package:core/presentation/blocs/section_popular_tv/section_popular_tv_bloc.dart';
import 'package:core/presentation/blocs/section_top_rated_movie/section_top_rated_movie_bloc.dart';
import 'package:core/presentation/blocs/section_top_rated_tv/section_top_rated_tv_bloc.dart';
import 'package:core/presentation/blocs/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:core/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:core/presentation/blocs/tv_search/tv_search_bloc.dart';
import 'package:core/presentation/blocs/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/blocs/watchlist_status_movie/watchlist_status_movie_cubit.dart';
import 'package:core/presentation/blocs/watchlist_status_tv/watchlist_status_tv_cubit.dart';
import 'package:core/presentation/blocs/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:core/presentation/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // bloc
  locator.registerFactory(() => TvSearchBloc(locator()));
  locator.registerFactory(() => NowPlayingTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => TvRecommendationBloc(locator()));
  locator.registerFactory(
    () => WatchlistStatusTvCubit(locator(), locator(), locator()),
  );
  locator.registerFactory(() => SectionNowPlayingTvBloc(locator()));
  locator.registerFactory(() => SectionPopularTvBloc(locator()));
  locator.registerFactory(() => SectionTopRatedTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(
    () => WatchlistStatusMovieCubit(locator(), locator(), locator()),
  );
  locator.registerFactory(() => SectionNowPlayingMovieBloc(locator()));
  locator.registerFactory(() => SectionPopularMovieBloc(locator()));
  locator.registerFactory(() => SectionTopRatedMovieBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // tv series usecase
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // tv series repository
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  // tv series data sources
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  // tv series helper
  locator.registerLazySingleton<TvSeriesDatabaseHelper>(
    () => TvSeriesDatabaseHelper(),
  );

  // external
  IOClient ioClient = await _getIoClient();
  locator.registerLazySingleton(() => ioClient);
  // locator.registerLazySingleton(() => http.Client());
}

Future<IOClient> _getIoClient() async {
  final sslCert = await rootBundle.load('certificates/tmdb.crt');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  HttpClient client = HttpClient(context: securityContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  return IOClient(client);
}

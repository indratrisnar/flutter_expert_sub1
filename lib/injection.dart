import 'package:submission1/data/datasources/db/database_helper.dart';
import 'package:submission1/data/datasources/db/tv_database_helper.dart';
import 'package:submission1/data/datasources/movie_local_data_source.dart';
import 'package:submission1/data/datasources/movie_remote_data_source.dart';
import 'package:submission1/data/repositories/movie_repository_impl.dart';
import 'package:submission1/data/repositories/tv_series_repository_impl.dart';
import 'package:submission1/domain/repositories/movie_repository.dart';
import 'package:submission1/domain/repositories/tv_series_repository.dart';
import 'package:submission1/domain/usecases/get_movie_detail.dart';
import 'package:submission1/domain/usecases/get_movie_recommendations.dart';
import 'package:submission1/domain/usecases/get_now_playing_movies.dart';
import 'package:submission1/domain/usecases/get_now_playing_tv_series.dart';
import 'package:submission1/domain/usecases/get_popular_movies.dart';
import 'package:submission1/domain/usecases/get_popular_tv_series.dart';
import 'package:submission1/domain/usecases/get_top_rated_movies.dart';
import 'package:submission1/domain/usecases/get_top_rated_tv_series.dart';
import 'package:submission1/domain/usecases/get_tv_series_detail.dart';
import 'package:submission1/domain/usecases/get_tv_series_recommendations.dart';
import 'package:submission1/domain/usecases/get_watchlist_movies.dart';
import 'package:submission1/domain/usecases/get_watchlist_status.dart';
import 'package:submission1/domain/usecases/get_watchlist_status_tv_series.dart';
import 'package:submission1/domain/usecases/get_watchlist_tv_series.dart';
import 'package:submission1/domain/usecases/remove_watchlist.dart';
import 'package:submission1/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:submission1/domain/usecases/save_watchlist.dart';
import 'package:submission1/domain/usecases/save_watchlist_tv_series.dart';
import 'package:submission1/domain/usecases/search_movies.dart';
import 'package:submission1/domain/usecases/search_tv_series.dart';
import 'package:submission1/presentation/provider/movie_detail_notifier.dart';
import 'package:submission1/presentation/provider/movie_list_notifier.dart';
import 'package:submission1/presentation/provider/movie_search_notifier.dart';
import 'package:submission1/presentation/provider/now_playing_tv_series_notifier.dart';
import 'package:submission1/presentation/provider/popular_movies_notifier.dart';
import 'package:submission1/presentation/provider/popular_tv_series_notifier.dart';
import 'package:submission1/presentation/provider/top_rated_movies_notifier.dart';
import 'package:submission1/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:submission1/presentation/provider/tv_detail_notifier.dart';
import 'package:submission1/presentation/provider/tv_list_notifier.dart';
import 'package:submission1/presentation/provider/tv_search_notifier.dart';
import 'package:submission1/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:submission1/presentation/provider/watchlist_tv_notifier.dart';

import 'data/datasources/tv_series_local_data_source.dart';
import 'data/datasources/tv_series_remote_data_source.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  // tv series provider
  locator.registerFactory(
    () => NowPlayingTvSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(locator()),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesNotifier(getTopRatedTvSeries: locator()),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(searchTvs: locator()),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(getWatchlistTvs: locator()),
  );

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
  locator.registerLazySingleton(() => http.Client());
}
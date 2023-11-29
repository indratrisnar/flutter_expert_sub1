import 'package:submission1/common/constants.dart';
import 'package:submission1/common/utils.dart';
import 'package:submission1/presentation/pages/about_page.dart';
import 'package:submission1/presentation/pages/home_page.dart';
import 'package:submission1/presentation/pages/movie_detail_page.dart';
import 'package:submission1/presentation/pages/popular_movies_page.dart';
import 'package:submission1/presentation/pages/search_page.dart';
import 'package:submission1/presentation/pages/search_tv_page.dart';
import 'package:submission1/presentation/pages/top_rated_movies_page.dart';
import 'package:submission1/presentation/pages/watchlist_movies_page.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/injection.dart' as di;
import 'package:submission1/presentation/provider/watchlist_tv_notifier.dart';

import 'presentation/pages/now_playing_tv_page.dart';
import 'presentation/pages/popular_tv_page.dart';
import 'presentation/pages/top_rated_tv_page.dart';
import 'presentation/pages/tv_detail_page.dart';
import 'presentation/pages/watchlist_tv_page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        // tv series
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case NowPlayingTvPage.route:
              return CupertinoPageRoute(
                  builder: (_) => const NowPlayingTvPage());
            case PopularTvPage.route:
              return CupertinoPageRoute(builder: (_) => const PopularTvPage());
            case TopRatedTvPage.route:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
            case TvDetailPage.route:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchTvPage.route:
              return CupertinoPageRoute(builder: (_) => const SearchTvPage());
            case WatchlistTvPage.route:
              return MaterialPageRoute(builder: (_) => const WatchlistTvPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

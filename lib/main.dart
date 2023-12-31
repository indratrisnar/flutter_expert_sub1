import 'package:about/about.dart';
import 'package:core/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/presentation/blocs/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:core/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:core/presentation/blocs/popular_tv/popular_tv_bloc.dart';
import 'package:core/presentation/blocs/section_now_playing_movie/section_now_playing_movie_bloc.dart';
import 'package:core/presentation/blocs/section_now_playing_tv/section_now_playing_tv_bloc.dart';
import 'package:core/presentation/blocs/section_popular_movie/section_popular_movie_bloc.dart';
import 'package:core/presentation/blocs/section_popular_tv/section_popular_tv_bloc.dart';
import 'package:core/presentation/blocs/section_top_rated_movie/section_top_rated_movie_bloc.dart';
import 'package:core/presentation/blocs/section_top_rated_tv/section_top_rated_tv_bloc.dart';
import 'package:core/presentation/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:core/presentation/blocs/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:core/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:core/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:core/presentation/blocs/tv_search/tv_search_bloc.dart';
import 'package:core/presentation/blocs/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/blocs/watchlist_status_movie/watchlist_status_movie_cubit.dart';
import 'package:core/presentation/blocs/watchlist_status_tv/watchlist_status_tv_cubit.dart';
import 'package:core/presentation/blocs/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/now_playing_tv_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_page.dart';
import 'package:core/presentation/pages/search_tv_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/pages/watchlist_tv_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/search.dart';
import 'package:submission1/firebase_options.dart';

import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<SearchBloc>(),
        ),
        // bloc submisi 2
        BlocProvider(
          create: (context) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistStatusTvCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SectionNowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SectionPopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SectionTopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistStatusMovieCubit>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SectionNowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SectionPopularMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SectionTopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieBloc>(),
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
            case popularMovieRoute:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case topRatedRoute:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchRoute:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case watchlistRoute:
              return MaterialPageRoute(
                  builder: (_) => const WatchlistMoviesPage());
            case nowPlayingTvRoute:
              return CupertinoPageRoute(
                  builder: (_) => const NowPlayingTvPage());
            case popularTvRoute:
              return CupertinoPageRoute(builder: (_) => const PopularTvPage());
            case topRatedTvRoute:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
            case tvDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case searchTvRoute:
              return CupertinoPageRoute(builder: (_) => const SearchTvPage());
            case watchlistTvRoute:
              return MaterialPageRoute(builder: (_) => const WatchlistTvPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}

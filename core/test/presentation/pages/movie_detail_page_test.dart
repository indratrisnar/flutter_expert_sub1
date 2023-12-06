import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
// import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:core/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:core/presentation/blocs/watchlist_status_movie/watchlist_status_movie_cubit.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
// import 'package:core/presentation/provider/movie_detail_notifier.dart';
// import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

// import '../../dummy_data/dummy_objects.dart';
// import 'movie_detail_page_test.mocks.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MockWatchlistStatusMovieCubit extends MockCubit<bool>
    implements WatchlistStatusMovieCubit {}

// @GenerateMocks([MovieDetailNotifier])
void main() {
  // late MockMovieDetailNotifier mockNotifier;
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockWatchlistStatusMovieCubit mockWatchlistStatusMovieCubit;

  setUp(() {
    // mockNotifier = MockMovieDetailNotifier();
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockWatchlistStatusMovieCubit = MockWatchlistStatusMovieCubit();
    HttpOverrides.global = null;
  });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<MovieDetailNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (context) => mockMovieRecommendationBloc,
        ),
        BlocProvider<WatchlistStatusMovieCubit>(
          create: (context) => mockWatchlistStatusMovieCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  // testWidgets(
  //     'Watchlist button should display add icon when movie not added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   final watchlistButtonIcon = find.byIcon(Icons.add);
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(
      () => mockMovieDetailBloc.state,
    ).thenReturn(MovieDetailLoaded(testMovieDetail));
    when(
      () => mockMovieRecommendationBloc.state,
    ).thenReturn(MovieRecommendationLoaded(const []));
    when(
      () => mockWatchlistStatusMovieCubit.state,
    ).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should dispay check icon when movie is added to wathclist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(true);

  //   final watchlistButtonIcon = find.byIcon(Icons.check);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(watchlistButtonIcon, findsOneWidget);
  // });
  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(
      () => mockMovieDetailBloc.state,
    ).thenReturn(MovieDetailLoaded(testMovieDetail));
    when(
      () => mockMovieRecommendationBloc.state,
    ).thenReturn(MovieRecommendationLoaded(const []));
    when(
      () => mockWatchlistStatusMovieCubit.state,
    ).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movie).thenReturn(testMovieDetail);
  //   when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //   when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //   when(mockNotifier.watchlistMessage).thenReturn('Failed');

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}

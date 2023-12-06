import 'package:bloc_test/bloc_test.dart';
// import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
// import 'package:core/presentation/provider/popular_movies_notifier.dart';
// import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
// import 'popular_movies_page_test.mocks.dart';

class MockPopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

// @GenerateMocks([PopularMoviesNotifier])
void main() {
  // late MockPopularMoviesNotifier mockNotifier;
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUp(() {
    // mockNotifier = MockPopularMoviesNotifier();
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<PopularMoviesNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (context) => mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  // testWidgets('Page should display center progress bar when loading',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loading);

  //   final progressBarFinder = find.byType(CircularProgressIndicator);
  //   final centerFinder = find.byType(Center);

  //   await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

  //   expect(centerFinder, findsOneWidget);
  //   expect(progressBarFinder, findsOneWidget);
  // });
  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  // testWidgets('Page should display ListView when data is loaded',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Loaded);
  //   when(mockNotifier.movies).thenReturn(<Movie>[]);

  //   final listViewFinder = find.byType(ListView);

  //   await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

  //   expect(listViewFinder, findsOneWidget);
  // });
  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMovieLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  // testWidgets('Page should display text with message when Error',
  //     (WidgetTester tester) async {
  //   when(mockNotifier.state).thenReturn(RequestState.Error);
  //   when(mockNotifier.message).thenReturn('Error message');

  //   final textFinder = find.byKey(Key('error_message'));

  //   await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

  //   expect(textFinder, findsOneWidget);
  // });
  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMovieFailure('Server Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Server Error'), findsOneWidget);
  });
}

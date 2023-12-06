import 'package:bloc_test/bloc_test.dart';
// import 'package:core/domain/entities/movie.dart';
// import 'package:core/presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'package:core/presentation/blocs/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
// import 'package:core/presentation/provider/top_rated_movies_notifier.dart';
// import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
// import 'top_rated_movies_page_test.mocks.dart';

class MockTopratedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

// @GenerateMocks([TopRatedMoviesNotifier])
void main() {
  // late MockTopRatedMoviesNotifier mockNotifier;
  late MockTopratedMovieBloc mockTopratedMovieBloc;

  setUp(() {
    // mockNotifier = MockTopRatedMoviesNotifier();
    mockTopratedMovieBloc = MockTopratedMovieBloc();
  });

  // Widget _makeTestableWidget(Widget body) {
  //   return ChangeNotifierProvider<TopRatedMoviesNotifier>.value(
  //     value: mockNotifier,
  //     child: MaterialApp(
  //       home: body,
  //     ),
  //   );
  // }
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (context) => mockTopratedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopratedMovieBloc.state).thenReturn(TopRatedMovieLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopratedMovieBloc.state)
        .thenReturn(TopRatedMovieLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopratedMovieBloc.state)
        .thenReturn(TopRatedMovieFailure('Server Error'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

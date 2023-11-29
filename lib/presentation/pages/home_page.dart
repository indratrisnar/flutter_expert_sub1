import 'package:flutter/material.dart';
import 'package:submission1/presentation/pages/home_movie_page.dart';
import 'package:submission1/presentation/pages/home_tv_page.dart';
import 'package:submission1/presentation/pages/search_page.dart';
import 'package:submission1/presentation/pages/search_tv_page.dart';
import 'package:submission1/presentation/pages/watchlist_tv_page.dart';

import 'about_page.dart';
import 'watchlist_movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> view = ValueNotifier(0);

  @override
  void dispose() {
    view.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListenableBuilder(
          listenable: view,
          builder: (context, child) => Text(
            view.value == 0 ? 'Movie' : 'Tv Series',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                view.value == 0 ? SearchPage.ROUTE_NAME : SearchTvPage.route,
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                view.value = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Series'),
              onTap: () {
                view.value = 1;
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Series Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.route);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      body: ListenableBuilder(
        listenable: view,
        builder: (context, child) {
          return IndexedStack(
            index: view.value,
            children: [HomeMoviePage(), const HomeTvPage()],
          );
        },
      ),
    );
  }
}

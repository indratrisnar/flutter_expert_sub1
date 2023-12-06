import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/blocs/section_now_playing_movie/section_now_playing_movie_bloc.dart';
import 'package:core/presentation/blocs/section_popular_movie/section_popular_movie_bloc.dart';
import 'package:core/presentation/blocs/section_top_rated_movie/section_top_rated_movie_bloc.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<SectionNowPlayingMovieBloc>()
          .add(OnGetSectionNowPlayingMovie());
      context.read<SectionPopularMovieBloc>().add(OnGetSectionPopularMovie());
      context.read<SectionTopRatedMovieBloc>().add(OnGetSectionTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<SectionNowPlayingMovieBloc,
                SectionNowPlayingMovieState>(
              builder: (context, state) {
                if (state is SectionNowPlayingMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SectionNowPlayingMovieLoaded) {
                  return MovieList(state.movies);
                } else if (state is SectionNowPlayingMovieFailure) {
                  return const Text('Failed');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, POPULAR_MOVIES_ROUTE),
            ),
            BlocBuilder<SectionPopularMovieBloc, SectionPopularMovieState>(
              builder: (context, state) {
                if (state is SectionPopularMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SectionPopularMovieLoaded) {
                  return MovieList(state.movies);
                } else if (state is SectionPopularMovieFailure) {
                  return const Text('Failed');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TOP_RATED_ROUTE),
            ),
            BlocBuilder<SectionTopRatedMovieBloc, SectionTopRatedMovieState>(
              builder: (context, state) {
                if (state is SectionTopRatedMovieLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SectionTopRatedMovieLoaded) {
                  return MovieList(state.movie);
                } else if (state is SectionTopRatedMovieFailure) {
                  return const Text('Failed');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MOVIE_DETAIL_ROUTE,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

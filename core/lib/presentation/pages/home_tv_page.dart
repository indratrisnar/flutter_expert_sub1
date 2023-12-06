import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_series_entity.dart';
import 'package:core/presentation/blocs/section_now_playing_tv/section_now_playing_tv_bloc.dart';
import 'package:core/presentation/blocs/section_popular_tv/section_popular_tv_bloc.dart';
import 'package:core/presentation/blocs/section_top_rated_tv/section_top_rated_tv_bloc.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SectionNowPlayingTvBloc>().add(OnGetSectionNowPlayingTv());
      context.read<SectionPopularTvBloc>().add(OnGetSectionPopularTv());
      context.read<SectionTopRatedTvBloc>().add(OnGetSectionTopRatedTv());
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
            _buildSubHeading(
              title: 'Now Playing',
              onTap: () => Navigator.pushNamed(context, nowPlayingTvRoute),
            ),
            BlocBuilder<SectionNowPlayingTvBloc, SectionNowPlayingTvState>(
              builder: (context, state) {
                if (state is SectionNowPlayingTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SectionNowPlayingTvLoaded) {
                  return TvList(state.tvs);
                } else if (state is SectionNowPlayingTvFailure) {
                  return const Text('Failed');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, popularTvRoute),
            ),
            BlocBuilder<SectionPopularTvBloc, SectionPopularTvState>(
              builder: (context, state) {
                if (state is SectionPopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SectionPopularTvLoaded) {
                  return TvList(state.tvs);
                } else if (state is SectionPopularTvFailure) {
                  return const Text('Failed');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, topRatedTvRoute),
            ),
            BlocBuilder<SectionTopRatedTvBloc, SectionTopRatedTvState>(
              builder: (context, state) {
                if (state is SectionTopRatedTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SectionTopRatedTvLoaded) {
                  return TvList(state.tvs);
                } else if (state is SectionTopRatedTvFailure) {
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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeriesEntity> tvs;

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvs.length,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvDetailRoute,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

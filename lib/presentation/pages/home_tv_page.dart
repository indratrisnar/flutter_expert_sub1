import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';
import 'package:submission1/presentation/pages/now_playing_tv_page.dart';
import 'package:submission1/presentation/pages/popular_tv_page.dart';
import 'package:submission1/presentation/pages/top_rated_tv_page.dart';
import 'package:submission1/presentation/pages/tv_detail_page.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../provider/tv_list_notifier.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvListNotifier>()
        ..fetchNowPlayingTvs()
        ..fetchPopularTvs()
        ..fetchTopRatedTvs(),
    );
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
              onTap: () => Navigator.pushNamed(context, NowPlayingTvPage.route),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.nowPlayingTvs);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () => Navigator.pushNamed(context, PopularTvPage.route),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.popularTvsState;
              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.popularTvs);
              } else {
                return const Text('Failed');
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () => Navigator.pushNamed(context, TopRatedTvPage.route),
            ),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTvsState;
              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.topRatedTvs);
              } else {
                return const Text('Failed');
              }
            }),
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
                  TvDetailPage.route,
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

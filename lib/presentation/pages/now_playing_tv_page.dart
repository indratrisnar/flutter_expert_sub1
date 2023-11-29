import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/presentation/provider/now_playing_tv_series_notifier.dart';
import 'package:submission1/presentation/widgets/tv_card_list.dart';

import '../../common/state_enum.dart';

class NowPlayingTvPage extends StatefulWidget {
  const NowPlayingTvPage({super.key});
  static const route = '/tv-now-playing';

  @override
  State<NowPlayingTvPage> createState() => NowPlayingTvPageState();
}

class NowPlayingTvPageState extends State<NowPlayingTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<NowPlayingTvSeriesNotifier>().fetchNowPlayingTvs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowPlayingTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: data.tvs.length,
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return TvCard(tv);
                },
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}

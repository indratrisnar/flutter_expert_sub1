import 'package:core/utils/state_enum.dart';

import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_series_entity.dart';
import '../../domain/usecases/get_now_playing_tv_series.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesNotifier(this.getNowPlayingTvSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeriesEntity> _tvs = [];
  List<TvSeriesEntity> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvs() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

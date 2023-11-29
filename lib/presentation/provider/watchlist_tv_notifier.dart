import 'package:submission1/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:submission1/domain/usecases/get_watchlist_tv_series.dart';

import '../../domain/entities/tv_series_entity.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTvs = <TvSeriesEntity>[];
  List<TvSeriesEntity> get watchlistTvs => _watchlistTvs;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTvs});

  final GetWatchlistTvSeries getWatchlistTvs;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvs.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvs = tvsData;
        notifyListeners();
      },
    );
  }
}

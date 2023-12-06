import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';

import '../../domain/entities/tv_series_entity.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  var _watchlistTvs = <TvSeriesEntity>[];
  List<TvSeriesEntity> get watchlistTvs => _watchlistTvs;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier({required this.getWatchlistTvs});

  final GetWatchlistTvSeries getWatchlistTvs;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvs.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _watchlistState = RequestState.loaded;
        _watchlistTvs = tvsData;
        notifyListeners();
      },
    );
  }
}

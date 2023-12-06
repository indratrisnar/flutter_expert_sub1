import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/utils/state_enum.dart';

import 'package:flutter/foundation.dart';

import '../../domain/entities/tv_series_entity.dart';

class PopularTvSeriesNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesNotifier(this.getPopularTvSeries);

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeriesEntity> _tvs = [];
  List<TvSeriesEntity> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}

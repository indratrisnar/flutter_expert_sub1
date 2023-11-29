import 'package:submission1/common/state_enum.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';
import 'package:submission1/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesNotifier({required this.getTopRatedTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeriesEntity> _tvs = [];
  List<TvSeriesEntity> get tvs => _tvs;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeriesEntitys() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();

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

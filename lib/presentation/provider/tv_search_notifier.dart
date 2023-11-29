import 'package:submission1/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:submission1/domain/usecases/search_tv_series.dart';

import '../../domain/entities/tv_series_entity.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvs;

  TvSearchNotifier({required this.searchTvs});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeriesEntity> _searchResult = [];
  List<TvSeriesEntity> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvs.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

import 'package:core/utils/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:core/domain/usecases/search_tv_series.dart';

import '../../domain/entities/tv_series_entity.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvs;

  TvSearchNotifier({required this.searchTvs});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<TvSeriesEntity> _searchResult = [];
  List<TvSeriesEntity> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvs.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}

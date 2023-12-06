import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';

import '../../domain/entities/tv_series_entity.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTvs = <TvSeriesEntity>[];
  List<TvSeriesEntity> get nowPlayingTvs => _nowPlayingTvs;

  RequestState _nowPlayingState = RequestState.empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popularTvs = <TvSeriesEntity>[];
  List<TvSeriesEntity> get popularTvs => _popularTvs;

  RequestState _popularTvsState = RequestState.empty;
  RequestState get popularTvsState => _popularTvsState;

  var _topRatedTvs = <TvSeriesEntity>[];
  List<TvSeriesEntity> get topRatedTvs => _topRatedTvs;

  RequestState _topRatedTvsState = RequestState.empty;
  RequestState get topRatedTvsState => _topRatedTvsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTvs,
    required this.getPopularTvs,
    required this.getTopRatedTvs,
  });

  final GetNowPlayingTvSeries getNowPlayingTvs;
  final GetPopularTvSeries getPopularTvs;
  final GetTopRatedTvSeries getTopRatedTvs;

  Future<void> fetchNowPlayingTvs() async {
    _nowPlayingState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvs.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _nowPlayingState = RequestState.loaded;
        _nowPlayingTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvs() async {
    _popularTvsState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvs.execute();
    result.fold(
      (failure) {
        _popularTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvsState = RequestState.loaded;
        _popularTvs = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvs() async {
    _topRatedTvsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();
    result.fold(
      (failure) {
        _topRatedTvsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvsState = RequestState.loaded;
        _topRatedTvs = tvsData;
        notifyListeners();
      },
    );
  }
}

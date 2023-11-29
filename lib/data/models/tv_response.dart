import 'package:equatable/equatable.dart';

import 'tv_series_model.dart';

class TvResponse extends Equatable {
  final List<TvSeriesModel> list;

  const TvResponse({required this.list});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        list: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(list.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [list];
}

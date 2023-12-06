part of 'tv_search_bloc.dart';

@immutable
sealed class TvSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnGetTvSearch extends TvSearchEvent {
  final String query;

  OnGetTvSearch(this.query);

  @override
  List<Object?> get props => [query];
}

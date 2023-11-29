import 'package:submission1/data/models/genre_model.dart';
import 'package:submission1/data/models/tv_series_detail_model.dart';
import 'package:submission1/data/models/tv_series_model.dart';
import 'package:submission1/data/models/tv_series_table.dart';
import 'package:submission1/domain/entities/genre.dart';
import 'package:submission1/domain/entities/tv_series_detail_entity.dart';
import 'package:submission1/domain/entities/tv_series_entity.dart';

final testTvSeriesEntity = TvSeriesEntity(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  id: 94722,
  originalLanguage: 'de',
  originalName: 'Tagesschau',
  overview:
      "German daily news program, the oldest still existing program on German television.",
  popularity: 3425.985,
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  firstAirDate: DateTime.parse("1952-12-26"),
  name: 'Tagesschau',
  voteAverage: 7.094,
  voteCount: 171,
  genreIds: const [10763],
);

final testTvSeriesList = [testTvSeriesEntity];

final testTvSeriesDetailEntity = TvSeriesDetailEntity(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  id: 94722,
  originalLanguage: 'de',
  originalName: 'Tagesschau',
  overview:
      "German daily news program, the oldest still existing program on German television.",
  popularity: 3425.985,
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  firstAirDate: DateTime.parse("1952-12-26"),
  name: 'Tagesschau',
  voteAverage: 7.094,
  voteCount: 171,
  createdBy: const [],
  episodeRunTime: const [15],
  genres: [Genre(id: 10763, name: 'News')],
  homepage: "https://www.tagesschau.de/",
  inProduction: true,
  lastAirDate: DateTime.parse("2023-11-26"),
  numberOfEpisodes: 20839,
  numberOfSeasons: 72,
  status: "Returning Series",
  tagline: '',
  type: "News",
  runtime: 15,
);

final testWatchlistTvSeries = TvSeriesEntity.watchlist(
  id: 94722,
  name: 'Tagesschau',
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

const testTvSeriesTable = TvSeriesTable(
  id: 94722,
  name: 'Tagesschau',
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  overview:
      "German daily news program, the oldest still existing program on German television.",
);

final testTvSeriesTableMap = {
  'id': 94722,
  'overview':
      "German daily news program, the oldest still existing program on German television.",
  'poster_path': "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  'name': 'Tagesschau',
};

final testTvSeriesModel = TvSeriesModel(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  id: 94722,
  originalLanguage: 'de',
  originalName: 'Tagesschau',
  overview:
      "German daily news program, the oldest still existing program on German television.",
  popularity: 3425.985,
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  firstAirDate: DateTime.parse("1952-12-26"),
  name: 'Tagesschau',
  voteAverage: 7.094,
  voteCount: 171,
  genreIds: const [10763],
);

final testTvSeriesDetailModel = TvSeriesDetailModel(
  adult: false,
  backdropPath: "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  id: 94722,
  originalLanguage: 'de',
  originalName: 'Tagesschau',
  overview:
      "German daily news program, the oldest still existing program on German television.",
  popularity: 3425.985,
  posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  firstAirDate: DateTime.parse("1952-12-26"),
  name: 'Tagesschau',
  voteAverage: 7.094,
  voteCount: 171,
  createdBy: const [],
  episodeRunTime: const [15],
  genres: [GenreModel(id: 10763, name: 'News')],
  homepage: "https://www.tagesschau.de/",
  inProduction: true,
  lastAirDate: DateTime.parse("2023-11-26"),
  numberOfEpisodes: 20839,
  numberOfSeasons: 72,
  status: "Returning Series",
  tagline: '',
  type: "News",
  runtime: 15,
);

final testTvSeriesDetailJson = {
  "adult": false,
  "backdrop_path": "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  "created_by": [],
  "episode_run_time": [15],
  "first_air_date": "1952-12-26",
  "genres": [
    {"id": 10763, "name": "News"}
  ],
  "homepage": "https://www.tagesschau.de/",
  "id": 94722,
  "in_production": true,
  "last_air_date": "2023-11-26",
  "name": "Tagesschau",
  "number_of_episodes": 20839,
  "number_of_seasons": 72,
  "original_language": "de",
  "original_name": "Tagesschau",
  "overview":
      "German daily news program, the oldest still existing program on German television.",
  "popularity": 3425.985,
  "poster_path": "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  "status": "Returning Series",
  "tagline": "",
  "type": "News",
  "vote_average": 7.094,
  "vote_count": 171,
  "last_episode_to_air": {
    "runtime": 15,
  },
};

final testTvSeriesJson = {
  'adult': false,
  'backdrop_path': "/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg",
  'id': 94722,
  'original_language': 'de',
  'original_name': 'Tagesschau',
  'overview':
      "German daily news program, the oldest still existing program on German television.",
  'popularity': 3425.985,
  'poster_path': "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
  'first_air_date': "1952-12-26",
  'name': 'Tagesschau',
  'vote_average': 7.094,
  'vote_count': 171,
  'genre_ids': const [10763],
};

// enric corrected 2022JUN14

// To parse this JSON data, do
//
//     final movieSuggestion = movieSuggestionFromMap(jsonString);

import 'dart:convert';
import '../model/listmovies.dart' as listmovie;

class MovieSuggestion {
  MovieSuggestion({
    required this.status,
    required this.statusMessage,
    required this.data,
    required this.meta,
  });

  final Stat? status;
  final String statusMessage;
  final Data data;
  final Meta meta;

  factory MovieSuggestion.fromJson(String str) =>
      MovieSuggestion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieSuggestion.fromMap(Map<String, dynamic> json) => MovieSuggestion(
        status: statValues.map![json["status"]],
        statusMessage: json["status_message"],
        data: Data.fromMap(json["data"]),
        meta: Meta.fromMap(json["@meta"]),
      );

  Map<String, dynamic> toMap() => {
        "status": statValues.reverse![status],
        "status_message": statusMessage,
        "data": data.toMap(),
        "@meta": meta.toMap(),
      };
}

class Data {
  Data({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<listmovie.Movie> movies;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        movieCount: json["movie_count"],
        limit: json["limit"],
        pageNumber: json["page_number"],
        movies: List<listmovie.Movie>.from(
            json["movies"].map((x) => listmovie.Movie.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "movie_count": movieCount,
        "limit": limit,
        "page_number": pageNumber,
        "movies": List<dynamic>.from(movies.map((x) => x.toMap())),
      };
}

/*
class Movie2 {
  Movie2({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.state,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String synopsis;
  final String ytTrailerCode;
  final Language? language;
  final MpaRating? mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;
  final Stat? state;
  final List<Torrent> torrents;
  final DateTime dateUploaded;
  final int dateUploadedUnix;

  factory Movie2.fromJson(String str) => Movie2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Movie2.fromMap(Map<String, dynamic> json) => Movie2(
        id: json["id"],
        url: json["url"],
        imdbCode: json["imdb_code"],
        title: json["title"],
        titleEnglish: json["title_english"],
        titleLong: json["title_long"],
        slug: json["slug"],
        year: json["year"],
        rating: json["rating"].toDouble(),
        runtime: json["runtime"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        summary: json["summary"],
        descriptionFull: json["description_full"],
        synopsis: json["synopsis"],
        ytTrailerCode: json["yt_trailer_code"],
        language: languageValues.map![json["language"]],
        mpaRating: mpaRatingValues.map![json["mpa_rating"]],
        backgroundImage: json["background_image"],
        backgroundImageOriginal: json["background_image_original"],
        smallCoverImage: json["small_cover_image"],
        mediumCoverImage: json["medium_cover_image"],
        largeCoverImage: json["large_cover_image"],
        state: statValues.map![json["state"]],
        torrents:
            List<Torrent>.from(json["torrents"].map((x) => Torrent.fromMap(x))),
        dateUploaded: DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "imdb_code": imdbCode,
        "title": title,
        "title_english": titleEnglish,
        "title_long": titleLong,
        "slug": slug,
        "year": year,
        "rating": rating,
        "runtime": runtime,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "summary": summary,
        "description_full": descriptionFull,
        "synopsis": synopsis,
        "yt_trailer_code": ytTrailerCode,
        "language": languageValues.reverse![language],
        "mpa_rating": mpaRatingValues.reverse![mpaRating],
        "background_image": backgroundImage,
        "background_image_original": backgroundImageOriginal,
        "small_cover_image": smallCoverImage,
        "medium_cover_image": mediumCoverImage,
        "large_cover_image": largeCoverImage,
        "state": statValues.reverse![state],
        "torrents": List<dynamic>.from(torrents.map((x) => x.toMap())),
        "date_uploaded": dateUploaded.toIso8601String(),
        "date_uploaded_unix": dateUploadedUnix,
      };
}
*/
enum Language { EN, RU, ES, JA }

final languageValues = EnumValues({
  "en": Language.EN,
  "es": Language.ES,
  "ja": Language.JA,
  "ru": Language.RU
});

enum MpaRating { EMPTY, R, PG_13 }

final mpaRatingValues = EnumValues(
    {"": MpaRating.EMPTY, "PG-13": MpaRating.PG_13, "R": MpaRating.R});

enum Stat { OK }

final statValues = EnumValues({"ok": Stat.OK});

class Torrent {
  Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  final String url;
  final String hash;
  final Quality? quality;
  final Type? type;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final DateTime dateUploaded;
  final int dateUploadedUnix;

  factory Torrent.fromJson(String str) => Torrent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Torrent.fromMap(Map<String, dynamic> json) => Torrent(
        url: json["url"],
        hash: json["hash"],
        quality: qualityValues.map![json["quality"]],
        type: typeValues.map![json["type"]],
        seeds: json["seeds"],
        peers: json["peers"],
        size: json["size"],
        sizeBytes: json["size_bytes"],
        dateUploaded: DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "hash": hash,
        "quality": qualityValues.reverse![quality],
        "type": typeValues.reverse![type],
        "seeds": seeds,
        "peers": peers,
        "size": size,
        "size_bytes": sizeBytes,
        "date_uploaded": dateUploaded.toIso8601String(),
        "date_uploaded_unix": dateUploadedUnix,
      };
}

enum Quality { THE_720_P, THE_1080_P }

final qualityValues =
    EnumValues({"1080p": Quality.THE_1080_P, "720p": Quality.THE_720_P});

enum Type { WEB, BLURAY }

final typeValues = EnumValues({"bluray": Type.BLURAY, "web": Type.WEB});

class Meta {
  Meta({
    required this.serverTime,
    required this.serverTimezone,
    required this.apiVersion,
    required this.executionTime,
  });

  final int serverTime;
  final String serverTimezone;
  final int apiVersion;
  final String executionTime;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        serverTime: json["server_time"],
        serverTimezone: json["server_timezone"],
        apiVersion: json["api_version"],
        executionTime: json["execution_time"],
      );

  Map<String, dynamic> toMap() => {
        "server_time": serverTime,
        "server_timezone": serverTimezone,
        "api_version": apiVersion,
        "execution_time": executionTime,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}

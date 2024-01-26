import 'dart:convert';

class MovieListModel {
  MovieListModel({
    this.search,
    this.totalResults,
    this.response,
    this.error
  });

  final List<Search>? search;
  final String? totalResults;
  final String? response;
  final String? error;


  MovieListModel movieListFromJson(String str) => MovieListModel.fromJson(json.decode(str));

  String movieListToJson(MovieListModel data) => json.encode(data);

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
    search: json["Search"] == null ? [] : List<Search>.from(json["Search"]!.map((x) => Search.fromMap(x))),
    totalResults: json["totalResults"],
    response: json["Response"],
    error: json["Error"],
  );

  Map<String, dynamic> toMap() => {
    "Search": search == null ? [] : List<dynamic>.from(search!.map((x) => x.toMap())),
    "totalResults": totalResults,
    "Response": response,
  };
}

class Search {
  Search({
    this.title,
    this.year,
    this.imdbId,
    this.type,
    this.poster,
  });

  final String? title;
  final String? year;
  final String? imdbId;
  final String? type;
  final String? poster;

  factory Search.fromJson(String str) => Search.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Search.fromMap(Map<String, dynamic> json) => Search(
    title: json["Title"],
    year: json["Year"],
    imdbId: json["imdbID"],
    type: json["Type"],
    poster: json["Poster"],
  );

  Map<String, dynamic> toMap() => {
    "Title": title,
    "Year": year,
    "imdbID": imdbId,
    "Type": type,
    "Poster": poster,
  };
}


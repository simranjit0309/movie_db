// To parse this JSON data, do
//
//     final movieDetailModel = movieDetailModelFromMap(jsonString);

import 'dart:convert';

class MovieDetailModel {
  MovieDetailModel({
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.ratings,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbId,
    this.type,
    this.dvd,
    this.boxOffice,
    this.production,
    this.website,
    this.response,
    this.error
  });

  final String? title;
  final String? year;
  final String? rated;
  final String? released;
  final String? runtime;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String? plot;
  final String? language;
  final String? country;
  final String? awards;
  final String? poster;
  final List<Rating>? ratings;
  final String? metascore;
  final String? imdbRating;
  final String? imdbVotes;
  final String? imdbId;
  final String? type;
  final String? dvd;
  final String? boxOffice;
  final String? production;
  final String? website;
  final String? response;
  final String? error;

  MovieDetailModel movieDetailFromJson(String str) => MovieDetailModel.fromJson(json.decode(str));

  String movieListToJson(MovieDetailModel data) => json.encode(data);


  String toJson() => json.encode(toMap());

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) => MovieDetailModel(
    title: json["Title"],
    year: json["Year"],
    rated: json["Rated"],
    released: json["Released"],
    runtime: json["Runtime"],
    genre: json["Genre"],
    director: json["Director"],
    writer: json["Writer"],
    actors: json["Actors"],
    plot: json["Plot"],
    language: json["Language"],
    country: json["Country"],
    awards: json["Awards"],
    poster: json["Poster"],
    ratings: json["Ratings"] == null ? [] : List<Rating>.from(json["Ratings"]!.map((x) => Rating.fromMap(x))),
    metascore: json["Metascore"],
    imdbRating: json["imdbRating"],
    imdbVotes: json["imdbVotes"],
    imdbId: json["imdbID"],
    type: json["Type"],
    dvd: json["DVD"],
    boxOffice: json["BoxOffice"],
    production: json["Production"],
    website: json["Website"],
    response: json["Response"],
    error: json["Error"],
  );

  Map<String, dynamic> toMap() => {
    "Title": title,
    "Year": year,
    "Rated": rated,
    "Released": released,
    "Runtime": runtime,
    "Genre": genre,
    "Director": director,
    "Writer": writer,
    "Actors": actors,
    "Plot": plot,
    "Language": language,
    "Country": country,
    "Awards": awards,
    "Poster": poster,
    "Ratings": ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x.toMap())),
    "Metascore": metascore,
    "imdbRating": imdbRating,
    "imdbVotes": imdbVotes,
    "imdbID": imdbId,
    "Type": type,
    "DVD": dvd,
    "BoxOffice": boxOffice,
    "Production": production,
    "Website": website,
    "Response": response,
    "Error": error,
  };
}

class Rating {
  Rating({
    this.source,
    this.value,
  });

  final String? source;
  final String? value;

  factory Rating.fromJson(String str) => Rating.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rating.fromMap(Map<String, dynamic> json) => Rating(
    source: json["Source"],
    value: json["Value"],
  );

  Map<String, dynamic> toMap() => {
    "Source": source,
    "Value": value,
  };
}

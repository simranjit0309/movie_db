import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/movie_detail_model.dart';
import '../models/movie_list_model.dart';
class RemoteService{

  RemoteService._privateConstructor();

  static final RemoteService _instance = RemoteService._privateConstructor();

  static RemoteService get instance => _instance;

  Future<MovieListModel> searchMovies(String movieName) async {
    var responseJson;
    try {
      print("https://www.omdbapi.com/?$movieName");
      var response = await http.post(Uri.parse("https://www.omdbapi.com/?$movieName"),);
      if(response.statusCode ==200) {
        responseJson = json.decode(response.body.toString());
      }
      log(responseJson.toString());
    }catch(e){
      print(e.toString());
    }
    return MovieListModel.fromJson(responseJson);
  }

  Future<MovieDetailModel> getMovie(String movieName) async {
    var responseJson;
    try {
      var response = await http.post(Uri.parse("https://www.omdbapi.com/?$movieName"),);
      if(response.statusCode ==200) {
        responseJson = json.decode(response.body.toString());
      }
      print(responseJson.toString());
    }catch(e){
      print(e.toString());
    }
    return MovieDetailModel.fromJson(responseJson);
  }
}
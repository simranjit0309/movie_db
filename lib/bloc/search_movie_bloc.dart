import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/bloc/search_movie_event.dart';
import 'package:movie_db/bloc/search_movie_state.dart';

import '../models/movie_list_model.dart';
import '../service/remote_service.dart';

class MovieSearchBloc extends Bloc<MovieEvent,SearchMovieState>{
  List<Search> movieList = List<Search>.empty(growable: true);
  MovieListModel movies = MovieListModel();
  bool isPagination = false;
  int page = 1;
  final TextEditingController textController = TextEditingController();
  RemoteService postService = RemoteService.instance;
  ScrollController scrollController = ScrollController();


  MovieSearchBloc() : super(InitialState()){
    print(postService.runtimeType);
    on<LoadingEvent>((event, emit) {
      emit(LoadingState());
      });
    on<ListMovieEvent>((event, emit) {
      emit(ResponseState(event.movieList));
    });
    on<ErrorEvent>((event, emit) {
      emit(ErrorState(event.errorMsg));
    });
    pagination();
  }

  Future<void> searchMovies(String? movieName,String page) async {
    try {
      add(LoadingEvent());
      var response = await postService.searchMovies("s=$movieName&page=$page&apikey=7aeca8c8");
      movies = response;
      if(response.response?.toLowerCase() == "true") {

        if(isPagination) {
          movieList.addAll(response.search!);
        }else{
          movieList.clear();
          movieList.addAll(response.search!);
        }
        add(ListMovieEvent(movieList));
      }else{
        add(ErrorEvent(response.error??"Something went wrong"));
        if (kDebugMode) {
          print(response.error);
        }
      }
    }catch(e){
      add(ErrorEvent("Something went wrong"));
    }finally{

    }
  }
  void pagination(){
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        isPagination = true;
        if(movies.response == "False"){
          return;
        }
        page++;
        searchMovies(textController.text,page.toString());
      }
    });
  }
}
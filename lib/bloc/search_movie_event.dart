import '../models/movie_list_model.dart';

abstract class MovieEvent {}

class SearchMovieEvent extends MovieEvent {
  final String query;
  SearchMovieEvent(this.query);
}

class ListMovieEvent extends MovieEvent {
  final List<Search> movieList;

  ListMovieEvent(this.movieList);
}

class ErrorEvent extends MovieEvent{
  final String errorMsg;

  ErrorEvent(this.errorMsg);
}


class LoadingEvent extends MovieEvent {}
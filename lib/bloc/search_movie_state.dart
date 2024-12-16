
import '../models/movie_list_model.dart';

abstract class SearchMovieState{}

class InitialState extends SearchMovieState{}

class LoadingState extends SearchMovieState{}

class ResponseState extends SearchMovieState{
  final List<Search> movieList;

  ResponseState(this.movieList);

}

class ErrorState extends SearchMovieState{
  final String errorMsg;

  ErrorState(this.errorMsg);
}
//
// class LoadMoreState extends SearchMovieState{
//
// }

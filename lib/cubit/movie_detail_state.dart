
import '../models/movie_detail_model.dart';

abstract class MovieDetailState{}

class InitialState extends MovieDetailState{}

class LoadingState extends MovieDetailState{}

class ResponseState extends MovieDetailState{
  final MovieDetailModel movieDetails;

  ResponseState(this.movieDetails);

}

class ErrorState extends MovieDetailState{
  final String errorMsg;

  ErrorState(this.errorMsg);
}

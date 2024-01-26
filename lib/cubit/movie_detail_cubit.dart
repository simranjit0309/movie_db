import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/models/movie_detail_model.dart';

import '../service/remote_service.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState>{
  MovieDetailModel movieDetail = MovieDetailModel();
  RemoteService postService = RemoteService.instance;
  MovieDetailCubit() : super(InitialState()){
    print(postService.runtimeType);
  }


  void getMovie(String movieName) async {
    try {
      emit(LoadingState());
      var response = await postService.getMovie("t=$movieName&plot=full&apikey=7aeca8c8");
      if(response.response == "True") {
        movieDetail = response;
        print(movieDetail);
        emit(ResponseState(movieDetail));
      }else{
        emit(ErrorState(movieDetail.error??"Something wen wrong"));
      }
    }catch(e){
      emit(ErrorState("Something wen wrong"));
    }finally{

    }
  }

}
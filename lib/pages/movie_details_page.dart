import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/cubit/movie_detail_cubit.dart';
import 'package:movie_db/cubit/movie_detail_state.dart';

class MovieDetailsPage extends StatelessWidget{
  final String? movieName;

  const MovieDetailsPage( {super.key,this.movieName,});

  @override
  Widget build(BuildContext context) {
    context.read<MovieDetailCubit>().getMovie(movieName??"");
    // Provider.of<MovieProvider>(context,listen: false).getMovie(movieName!, context);
    return Scaffold(
      appBar: AppBar(
        title: Text(movieName??""),
      ),
      body:  SafeArea(
          child: BlocConsumer<MovieDetailCubit,MovieDetailState>(
            listener: (context,state){
              if(state is ErrorState){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.errorMsg),
                  backgroundColor: Colors.red,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(5),
                ));
              }
            },
            builder: (context,state){
             if(state is ResponseState ){
               final movieData = state.movieDetails;
               return  SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column (
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           CachedNetworkImage(
                               height: 250,
                               width: 180,
                               fit: BoxFit.cover,
                               imageUrl: movieData.poster??"",
                               placeholder: (ctx, url) =>  Image.asset('images/placeholder.jpg'),
                               errorWidget: (ctx, url, error) =>  Image.asset('images/error_image.jpg')
                           ),


                           SizedBox(width: 5,),
                           Expanded(child:  Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('Title: ${movieData.title??""}',style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 18,
                               ),maxLines: 2,),
                               const SizedBox(height: 10,),
                               Text('Year: ${movieData.year??""}',style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 18,
                               ),maxLines: 2),
                               const SizedBox(height: 10,),
                               Text('Release-Date: ${movieData.released??""}',style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 18,
                               ),maxLines: 2),
                               const SizedBox(height: 10,),
                               Text('Genre: ${movieData.genre??""}',style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 18,
                               ),maxLines: 2),
                               Text('IMDB Rating: ${movieData.imdbRating??""}',style: const TextStyle(
                                 color: Colors.black,
                                 fontSize: 18,
                               ),maxLines: 2),
                             ],
                           ))
                         ],
                       ),
                       Text('Awards: ${movieData.awards??""}',style: const TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                       ),maxLines: 2),
                       const SizedBox(height: 5,),
                       Text('Language: ${movieData.language??""}',style: const TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                       ),maxLines: 2),
                       const SizedBox(height: 5,),
                       Text('Plot: ${movieData.plot??""}',textAlign:TextAlign.justify,style: const TextStyle(
                         color: Colors.black,
                         fontSize: 18,
                       ),),
                     ],
                   ),
                 ),
               );
             }
             else if (state is LoadingState){
               return const Center(child: CircularProgressIndicator(),);
             }
             return const Center(child: CircularProgressIndicator(),);
            },
          )

      ),
    );
  }

}
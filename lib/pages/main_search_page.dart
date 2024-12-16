import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../bloc/search_movie_bloc.dart';
import '../bloc/search_movie_state.dart';
import 'movie_details_page.dart';
import 'package:marquee/marquee.dart';



class MainSearchPage extends StatelessWidget{
  const MainSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc =BlocProvider.of<MovieSearchBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Movie DB"),backgroundColor: Colors.blue,),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: movieBloc.textController,
                  decoration:  InputDecoration(
                      hintText: "Enter a movie to search",
                      suffixIcon: IconButton(onPressed: ()  {
                        FocusManager.instance.primaryFocus?.unfocus();
                        movieBloc.isPagination = false;
                        movieBloc.page = 1;
                        movieBloc.searchMovies(movieBloc.textController.text,"1");
                      }, icon: const Icon(Icons.search))
                  ),
                  maxLines: 1,

                ),
                BlocConsumer<MovieSearchBloc,SearchMovieState>(
                  listener: (context,state){
                    if(state is ErrorState){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                        elevation: 10,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(5),
                      ));
                    }else if (state is LoadingState ){
                      Loader.show(context,progressIndicator:const CircularProgressIndicator());
                    }else if(state is ResponseState){
                      Loader.hide();
                    }
                  },
                  builder: (ctx,state){
                    if(state is ResponseState){
                      final movieList = state.movieList;
                      return Expanded(child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GridView.builder(
                            controller: movieBloc.scrollController,
                            itemCount: movieList.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (ctx,index){
                              final movieListData = movieList.elementAt(index);
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      ctx,
                                      MaterialPageRoute(builder: (ctx) => MovieDetailsPage(movieName: movieListData.title,)),
                                    );
                                  },
                                  child: GridTile(
                                    footer:  GridTileBar(
                                      backgroundColor: Colors.black87,
                                      title: movieList.elementAt(index).title!.length>14?Marquee(
                                        blankSpace: 25.0,
                                        velocity: 40.0,
                                        text:movieListData.title??"",

                                      ):Text(movieListData.title??"",textAlign: TextAlign.center,),
                                    ),
                                    child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: movieListData.poster??"",
                                        placeholder: (ctx, url) =>  Image.asset('images/placeholder.jpg'),
                                        errorWidget: (ctx, url, error) =>  Image.asset('images/error_image.jpg')
                                    ),
                                  ),
                                ),
                              );
                            },

                          ),

                      ),
                      );
                    }

                    if(state is InitialState){
                      return const Center(child: Text("Search a Movie"));
                    }
                    return Container();
                  },
                )

              ],
            )
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:movie_db/pages/main_search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/pages/movie_details_page.dart';
import 'bloc/search_movie_bloc.dart';
import 'cubit/movie_detail_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

        providers: [
          BlocProvider(
            create: (context) => MovieSearchBloc(),
          ),
          BlocProvider(
            create: (context) => MovieDetailCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MovieDB',
          home: const MainSearchPage(),
          routes: {
            '/main_page': (ctx) => const MainSearchPage(),
            '/movie_detail': (ctx) =>  const MovieDetailsPage(),
          },
        ));
  }
}

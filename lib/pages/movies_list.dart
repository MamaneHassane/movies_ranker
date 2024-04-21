// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:movies_ranker/components/movie_card.dart';
import 'package:movies_ranker/models/movie.dart';
import 'package:movies_ranker/models/popular_movies.dart';
import 'package:movies_ranker/pages/movie_details.dart';
import 'package:movies_ranker/services/movies_service.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({super.key});

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  // Le service avec la clé de l'api
  final moviesService = MoviesService("7fda431b904d656ba41fa3832f43bda6");

  // Le numéro de la page actuelle
  int pageNumber = 0;

  // Le contrôlleur pour scroller
  final ScrollController scrollController = ScrollController();

  // La liste des films depuis l'api
  late List<Movie> moviesToAppend; 

  // La liste des films à afficher
  late Future<List<Movie>> moviesToShow;

  // Savoir si les films sont en train de charger ou non
  bool isLoading = false;

  // La fonction qui va ajouter des éléments
  void loadMoreMovies() async {
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        setState(() {
          isLoading = true;
          pageNumber+=1; 
        }); 
        moviesToAppend = await moviesService.loadMovies(pageNumber);
        List<Movie> allMovies = await moviesToShow;
        setState(() {
          allMovies.addAll(moviesToAppend); 
        });
        setState(() {
          isLoading = false;
        }); 
       }
    }


  @override
  void initState() {
    super.initState();
    scrollController.addListener(loadMoreMovies);
    if(pageNumber==0) {
      pageNumber = 1;
      moviesToShow = moviesService.loadMovies(pageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = FutureBuilder<List<Movie>>(    
      future: moviesToShow,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else {
          return ListView.builder(
            controller: scrollController, // Très important pour l'infinite scroll
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(12),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var movieToSee = snapshot.data![index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetails(movieToSee: movieToSee)
                    )
                  );  
                },
                child: MovieCard(
                  movie: movieToSee,
                ),
              );
            },
          );
        }
      },
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 6, bottom: 6),
            child: Text(
              "Meilleurs films du moment💕💕💕",
              style : GoogleFonts.abel(
                color: Colors.red,
                fontSize : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: futureBuilder,
          ),
          if(isLoading) 
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.pink,
                )
              ),
            )
        ]
      ),
    );
  }
}
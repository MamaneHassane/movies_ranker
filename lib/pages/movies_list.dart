// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_ranker/components/movie_card.dart';
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

  // La liste des films
  late Future<PopularMovies> popularMovies ;
  

  @override
  void initState() {
    super.initState();
    popularMovies = moviesService.loadMovies(1);
  }

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder<PopularMovies>(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.all(12),
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      var movieToSee = snapshot.data!.results[index];
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
            ),
          )
        ]
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_ranker/models/movie.dart';
import 'package:movies_ranker/services/movies_service.dart';

class MovieCard extends StatelessWidget {

  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8)
            ),
            child: Image.network("${MoviesService.imageBaseUrl}/w92/${movie.posterPath}",),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title!.length>=30 ? "${movie.title?.substring(0,30)}..." 
                    :
                    "${movie.title}" ,
                    style : GoogleFonts.abel(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                    )
                  ),
                    
                  Padding(
                    padding: const EdgeInsets.only(top : 12,),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            "lib/images/gold-star.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Text(
                          movie.voteAverage.toString(),
                          style: GoogleFonts.abel(
                            color: Colors.black,
                            fontSize : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),            
    );
  }
}
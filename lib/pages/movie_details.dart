// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_ranker/models/movie.dart';

class MovieDetails extends StatelessWidget {

  // Le film
  final Movie movieToSee;


  // Constructeur
  const MovieDetails({
    super.key,
    required this.movieToSee
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text(
                movieToSee.title!,
                style : GoogleFonts.abel(
                color: Colors.red,
                fontSize : 28,
                fontWeight: FontWeight.bold,
              )
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            )
        ]),
      ),
    );
  }
}

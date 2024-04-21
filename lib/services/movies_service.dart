import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_ranker/models/movie.dart';
import 'package:movies_ranker/models/popular_movies.dart';

class MoviesService {
  
  // La racine des url
  static const baseUrl = "https://api.themoviedb.org/3";
  // La racine des url des images
  static const imageBaseUrl = "https://image.tmdb.org/t/p";
  // La clé de l'api
  final String apiKey;
  // Le constructeur
  MoviesService(this.apiKey);

  // Fonction pour charger les films
  Future<List<Movie>> loadMovies(int pageNumber) async {
    final response = await http.get(Uri.parse("$baseUrl/movie/popular?page=$pageNumber&api_key=$apiKey"));
    if(response.statusCode == 200){
      return PopularMovies.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception("Une erreur s'est produite lors du chargement des films");
    }
  }

  // Fonction pour avoir les détails d'un film
  Future<Movie> getMovieDetails(String movieId) async {
    final response = await http.get(Uri.parse("$baseUrl/movie/$movieId?api_key=$apiKey"));
    if(response.statusCode == 200){
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Une erreur s'est produite lors du chargement du film");
    }
  }

  // Fonction pour ajouter des films à la liste des films chargés
  Future<List<Movie>> appendElements(Future<List<Movie>> listFuture, List<Movie> elementsToAdd) async {
    final list = await listFuture;
    list.addAll(elementsToAdd);
    return list;
  }

}
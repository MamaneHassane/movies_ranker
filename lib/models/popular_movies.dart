import 'movie.dart';

class PopularMovies {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  PopularMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  List<Movie> getResults() => results;
  

  factory PopularMovies.fromJson(Map<String, dynamic> json) {
    return PopularMovies(
      page: json['page'] as int,
      results: (json['results'] as List).map((movieJson) => Movie.fromJson(movieJson)).toList(),
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
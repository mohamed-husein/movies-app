import '../model/crew_model.dart';
import '../model/genres_model.dart';
import '../model/trailer_model.dart';

import '../model/details_model.dart';
import '../model/movies_model.dart';
import '../network/movies_services.dart';

class MoviesRepository {
  final MoviesWebServices moviesServices;

  MoviesRepository({required this.moviesServices,});

  Future<List<Movies>> nowPlayingMovies() async {
    final response = await moviesServices.getNowPlayingMovies();
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }

  Future<List<Movies>> popularMovies(String page) async {
    final response = await moviesServices.getPopular(page);
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }

  Future<List<Movies>> topRated(String page) async {
    final response = await moviesServices.getTopRated(page);
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }

   Future<List<Genres>> genres() async {
    final response = await moviesServices.getGenres();
    return List<Genres>.from(
      (response.data["genres"] as List).map(
        (e) => Genres.fromJson(e),
      ),
    );
  }

  Future<List<Movies>> moviesByFilter(String filter,String year,String page) async {
    final response = await moviesServices.getMoviesByFilter(filter,year,page);
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }
  Future<List<Movies>> moviesByQuery(String query) async {
    final response = await moviesServices.getMoviesByQuery(query);
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }

   Future<MoviesDetails> moviesDetails(int id) async {
    final response = await moviesServices.getMoviesDetails(id);
    return MoviesDetails.fromJson(response.data);
  }

   Future<List<Movies>> recommendedMovies(int id) async {
    final response = await moviesServices.getRecommendedMovies(id);
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }

  Future<List<CrewModel>> crew(int id) async {
    final response = await moviesServices.getCrew(id);
    return List<CrewModel>.from(
      (response.data["cast"] as List).map(
        (e) => CrewModel.fromJson(e),
      ),
    );
  }

  Future<List<Movies>> trendingMovies(String page) async {
    final response = await moviesServices.getTrendingMovies(page);
    return List<Movies>.from(
      (response.data["results"] as List).map(
        (e) => Movies.fromJson(e),
      ),
    );
  }

  Future<List<Trailar>> getTrailar(int id) async {
    final response = await moviesServices.getTrailar(id);
    return List<Trailar>.from(
      (response.data["results"] as List).map(
        (e) => Trailar.fromJson(e),
      ),
    );
  }
}

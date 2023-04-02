class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'b10a9908fcb56fe5120e516026d96c28';
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static const String sortBy = 'sort_by=with_genres';
  static const String lang = 'language=en-US';
  static const String withGenres = 'with_genres';
  static const String emptyPoster = 'https://excelautomationinc.com/wp-content/uploads/2021/07/No-Photo-Available.jpg';

  static const String nowPlayingPath =
      '$baseUrl/movie/now_playing?api_key=$apiKey';
  static  String popularPath(String page) => '$baseUrl/movie/popular?api_key=$apiKey&page=$page';
  static  String getTopRated(String page) => '$baseUrl/movie/top_rated?api_key=$apiKey&page=$page';
  static const String getGenres = '$baseUrl/genre/movie/list?api_key=$apiKey';
  static  String getTrending(String page) => '$baseUrl/trending/all/day?api_key=$apiKey&page=$page';
  static String getCrew(int moviesId) =>'$baseUrl/movie/$moviesId/credits?api_key=$apiKey';
  static String getTrailar(int moviesId) =>'$baseUrl/movie/$moviesId/videos?api_key=$apiKey';
  static String getMoviesByQuery(String query) =>
      '$baseUrl/search/movie?api_key=$apiKey&query=$query';
  static String getMoviesByFilter(String filter, String year,String page) =>
      '$baseUrl/discover/movie?api_key=$apiKey&$lang&$sortBy&with_genres=$filter&year=$year&page=$page';

  static String recommendation(int moviesId) =>
      '$baseUrl/movie/$moviesId/recommendations?api_key=$apiKey';
  static String moviesDetails(int moviesId) =>
      '$baseUrl/movie/$moviesId?api_key=$apiKey';
  static String imageUrl(String? path) {
    return  path == ''? emptyPoster : '$baseImageUrl$path';
  }
}

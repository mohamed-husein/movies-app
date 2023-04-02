import 'dart:io';

import 'package:dio/dio.dart';
import '../../core/errors/app_exception.dart';
import '../../core/utils/api_constants.dart';

class MoviesWebServices {
  Future<Response> getNowPlayingMovies() async {
    Response returnResponse;
    try {
      Response response = await Dio().get(ApiConstants.nowPlayingPath);

      returnResponse = _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return returnResponse;
  }

  Future<Response> getPopular(String page) async {
    Response returnResponse;
    try {
      Response response = await Dio().get(ApiConstants.popularPath(page));
      returnResponse = _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return returnResponse;
  }

  Future<Response> getTopRated(String page) async {
    Response returnResponse;
    try {
      Response response = await Dio().get(ApiConstants.getTopRated(page));

      returnResponse = _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return returnResponse;
  }

  Future<Response> getGenres() async {
    try {
      Response response = await Dio().get(ApiConstants.getGenres);

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<Response> getMoviesByFilter(String filter, String year,String page) async {
    try {
      Response response =
          await Dio().get(ApiConstants.getMoviesByFilter(filter, year,page));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<Response> getMoviesByQuery(String query) async {
    try {
      Response response = await Dio().get(ApiConstants.getMoviesByQuery(query));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<Response> getMoviesDetails(int id) async {
    try {
      Response response = await Dio().get(ApiConstants.moviesDetails(id));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<Response> getRecommendedMovies(int id) async {
    try {
      Response response = await Dio().get(ApiConstants.recommendation(id));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<Response> getCrew(int id) async {
    try {
      Response response = await Dio().get(ApiConstants.getCrew(id));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }



  Future<Response> getTrendingMovies(String page) async {
    try {
      Response response = await Dio().get(ApiConstants.getTrending(page));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Future<Response> getTrailar(int id) async {
    try {
      Response response = await Dio().get(ApiConstants.getTrailar(id));

      return _errorHandler(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
  }

  Response _errorHandler(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response;
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.data.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server with status code${response.statusCode}');
    }
  }
}

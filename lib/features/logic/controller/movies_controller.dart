import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/genres_model.dart';
import '../../model/movies_model.dart';
import '../../network/movies_services.dart';
import '../../repository/movies_repository.dart';

import '../../../core/enums/status.dart';

class MoviesController extends GetxController {
  final _api = MoviesRepository(moviesServices: MoviesWebServices());
  final rxRequestStatus = Status.loading.obs;
  final rxTopRatedRequestStatus = Status.loading.obs;
  final rxPopularRequestStatus = Status.loading.obs;
  final rxNowPlayingRequestStatus = Status.loading.obs;
  final popularMovies = <Movies>[].obs;
  final nowPlayingMovies = <Movies>[].obs;
  final topRated = <Movies>[].obs;
  final moviesByGenres = <Movies>[].obs;
  final moviesByQuery = <Movies>[].obs;
  final genres = <Genres>[].obs;
  final filterSearch = <String>[].obs;

  final editController = TextEditingController();
  final yearController = TextEditingController();

  int currentIndex = -1;
  RxString error = ''.obs;
  final currentPage = 1.obs;
  void setError(String value) => error.value = value;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setTopRatedRequestStatus(Status value) =>
      rxTopRatedRequestStatus.value = value;
  void setPopularRequestStatus(Status value) =>
      rxPopularRequestStatus.value = value;
  void setNowPlayingRequestStatus(Status value) =>
      rxNowPlayingRequestStatus.value = value;
  void setPopularMovies(List<Movies> value) => popularMovies.value = value;
  void setFilterSearch(List<String> value) => filterSearch.value = value;
  void setNowPlayingMovies(List<Movies> value) =>
      nowPlayingMovies.value = value;
  void setTopRated(List<Movies> value) => topRated.value = value;
  void setGenres(List<Genres> value) => genres.value = value;
  void setMoviesByGenres(List<Movies> value) => moviesByGenres.value = value;
  void setMoviesByQuery(List<Movies> value) => moviesByQuery.value = value;

  Future<void> getPopularMovies([String page = '1']) async {
    setPopularRequestStatus(Status.loading);
    await _api.popularMovies(page).then(
      (value) {
        setPopularMovies(value);
        setPopularRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxPopularRequestStatus(Status.error);
    });
  }

  Future<void> getNowPlayingMovies([String page = '1']) async {
    setNowPlayingRequestStatus(Status.loading);
    await _api.nowPlayingMovies().then(
      (value) {
        setNowPlayingMovies(value);
        setNowPlayingRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxNowPlayingRequestStatus(Status.error);
    });
  }

  final genre = ''.obs;
  void setGenre(String value) {
    genre.value = value;
  }

  void changeIndex(int index) {
    currentIndex = index;
    getMoviesByGenres(
      genres[index].id.toString(),
    );
    setGenre(genres[index].id.toString());

    update();
  }

  void resetIndex() {
    currentIndex = -1;
    isSearch.value = false;
    setMoviesByGenres([]);
    setMoviesByQuery([]);
    setFilterSearch([]);
    getGenres();
    currentPage.value = 1;
    yearController.clear();
    update();
  }

  Future<void> getTopRatedMovies([String page = '1']) async {
    setTopRatedRequestStatus(Status.loading);
    _api.topRated(page).then(
      (value) {
        setTopRated(value);
        setTopRatedRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      setTopRatedRequestStatus(Status.error);
    });
  }

  Future<void> getMoviesByGenres(
    String genres, [
    String year = '',
    String page = '1',
  ]) async {
    await _api.moviesByFilter(genres, year, page).then(
      (value) {
        setMoviesByGenres(value);
        setRxRequestStatus(Status.complete);
        moviesByGenres.refresh();
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxRequestStatus(Status.error);
    });
  }

  final isSearch = false.obs;
  Future<void> getMoviesByQuery(String query) async {
    isSearch.value = true;
    await _api.moviesByQuery(query).then(
      (value) {
        setMoviesByGenres(value);

        setRxRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxRequestStatus(Status.error);
    });
  }

  Future<void> getGenres() async {
    await _api.genres().then(
      (value) {
        setGenres(value);
        setRxRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxRequestStatus(Status.error);
    });
  }

  void selectFilter(int index) {
    genres[index].isChecked = !genres[index].isChecked;
    if (filterSearch.contains(genres[index].id.toString())) {
      filterSearch.remove(genres[index].id.toString());
    } else {
      filterSearch.add(genres[index].id.toString());
    }
    genres.refresh();
  }

  void resetCurrentPage(int value) {
    currentPage.value = value;
  }

  void changeCurrentPage(index) {
    currentPage.value = index;

    getMoviesByGenres(genre.value, '', index.toString());
    moviesByGenres.refresh();
  }

  void getMorePopularMovies(index) {
    currentPage.value = index;
    getPopularMovies(index.toString());
  }

  void getMoreTopRatedMovies(index) {
    currentPage.value = index;
    getTopRatedMovies(index.toString());
  }

  @override
  void onInit() {
    getPopularMovies();
    getNowPlayingMovies();
    getTopRatedMovies();
    getGenres();
    super.onInit();
  }

  @override
  void onClose() {
    editController.dispose();
    yearController.dispose();
    super.onClose();
  }
}

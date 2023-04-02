import 'package:get/get.dart';

import '../../../core/enums/status.dart';
import '../../model/movies_model.dart';
import '../../network/movies_services.dart';
import '../../repository/movies_repository.dart';

class TrendingController extends GetxController {
  final _api = MoviesRepository(moviesServices: MoviesWebServices());

  final rxTrendingRequestStatus = Status.loading.obs;
  final trendingMovies = <Movies>[].obs;
  RxString error = ''.obs;
  final currentPage = 1.obs;
  void setError(String value) => error.value = value;
  void setRxTrendingRequestStatus(Status value) =>
      rxTrendingRequestStatus.value = value;
  void setTrendingMovies(List<Movies> value) => trendingMovies.value = value;

  Future<void> getTendingMovies([String page = '1']) async {
   // setRxTrendingRequestStatus(Status.loading);
    await _api.trendingMovies(page).then(
      (value) {
        setTrendingMovies(value);
        setRxTrendingRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxTrendingRequestStatus(Status.error);
    });
  }

  void getMoreTrendingMovies(index) {
    currentPage.value = index;
    getTendingMovies(index.toString());
  }


  @override
  void onInit() {
    getTendingMovies();
    super.onInit();
  }
}

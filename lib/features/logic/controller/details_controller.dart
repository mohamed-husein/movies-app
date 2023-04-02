import 'package:get/get.dart';
import '../../model/crew_model.dart';
import '../../model/details_model.dart';

import '../../../core/enums/status.dart';
import '../../model/movies_model.dart';
import '../../network/movies_services.dart';
import '../../repository/movies_repository.dart';

class DetailsController extends GetxController {
  final _api = MoviesRepository(moviesServices: MoviesWebServices());

  final rxDetailsRequestStatus = Status.loading.obs;
  final Rx<MoviesDetails> moviesDetails = const MoviesDetails().obs;
  final recommendedMovies = <Movies>[].obs;
  final crew = <CrewModel>[].obs;
  RxString error = ''.obs;
  void setError(String value) => error.value = value;
  void setRxDetailsRequestStatus(Status value) =>
      rxDetailsRequestStatus.value = value;
  void setRecommendedMovies(List<Movies> value) =>
      recommendedMovies.value = value;
  void setCrew(List<CrewModel> value) => crew.value = value;

  void setMoviesDetails(MoviesDetails value) {
    moviesDetails.value = value;
  }

  Future<void> getMoviesDetails(int id) async {
    rxDetailsRequestStatus(Status.loading);
    await _api.moviesDetails(id).then(
      (value) {
        setMoviesDetails(value);
        setRxDetailsRequestStatus(Status.complete);
      },
    )
    .onError((error, stackTrace) {
      setError(error.toString());
      rxDetailsRequestStatus(Status.error);
    });
  }

  Future<void> getRecommendedMovies(int id) async {
    setRxDetailsRequestStatus(Status.loading);
    await _api.recommendedMovies(id).then(
      (value) {
        setRecommendedMovies(value);
        setRxDetailsRequestStatus(Status.complete);
      },
    )
    .onError((error, stackTrace) {
      setError(error.toString());
      rxDetailsRequestStatus(Status.error);
    });
  }

  Future<void> getCrew(int id) async {
    setRxDetailsRequestStatus(Status.loading);
    await _api.crew(id).then(
      (value) {
        setCrew(value);
        setRxDetailsRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxDetailsRequestStatus(Status.error);
    });
  }

  @override
  void onInit() {
    getMoviesDetails(Get.arguments);
    getRecommendedMovies(Get.arguments);
    getCrew(Get.arguments);

    super.onInit();
  }
}

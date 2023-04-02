import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/enums/status.dart';
import '../../model/trailer_model.dart';
import '../../network/movies_services.dart';
import '../../repository/movies_repository.dart';

class TrailarController extends GetxController {
  final _api = MoviesRepository(moviesServices: MoviesWebServices());

  late YoutubePlayerController controller;

  final rxTrailerRequestStatus = Status.loading.obs;

  RxString error = ''.obs;
  void setError(String value) => error.value = value;
  void setRxTrailarRequestStatus(Status value) =>
      rxTrailerRequestStatus.value = value;

  final trailar = <Trailar>[].obs;
  void setTrailar(List<Trailar> value) => trailar.value = value;

  Future<void> getTrailarOfMovie(int id) async {
    setRxTrailarRequestStatus(Status.loading);
    _api.getTrailar(id).then(
      (value) {
        setTrailar(value);
        controller = YoutubePlayerController(
          initialVideoId: getUrl(value[0].key),
          flags: const YoutubePlayerFlags(mute: true),
        );
        setRxTrailarRequestStatus(Status.complete);
      },
    ).onError((error, stackTrace) {
      setError(error.toString());
      rxTrailerRequestStatus(Status.error);
    });
  }

  String getUrl(String key) {
    return YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=$key')
        .toString();
  }

  @override
  void onInit() {
    getTrailarOfMovie(Get.arguments);

    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

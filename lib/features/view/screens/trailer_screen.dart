import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../core/utils/custom_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/enums/status.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_sizes.dart';
import '../../logic/controller/trailar_controller.dart';

class TrailerScreen extends GetView<TrailarController> {
  const TrailerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText.bodyMedium('Trailar', context: context),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ThemeColor.white,
              )),
        ),
        body: Obx(
          () {
            switch (controller.rxTrailerRequestStatus.value) {
              case Status.loading:
                return Padding(
                  padding: EdgeInsets.all(
                    AppSizes.pW90,
                  ),
                  child: Center(
                    child: Lottie.asset(
                      AppAssets.loading,
                    ),
                  ),
                );
              case Status.complete:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayerBuilder(
                      player: YoutubePlayer(controller: controller.controller),
                      builder: (p0, p1) =>
                          YoutubePlayer(controller: controller.controller),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSizes.pH12, horizontal: AppSizes.pW16),
                      child: CustomText.bodyMedium(controller.trailar[0].name,
                          textAlign: TextAlign.start, context: context),
                    )
                  ],
                );
              case Status.error:
                return CustomText.bodyMedium(controller.error.value,
                    context: context);
            }
          },
        ),
      ),
    );
  }
}

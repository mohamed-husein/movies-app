import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../logic/controller/movies_controller.dart';
import 'more_popular.dart';
import 'movies_info_widget.dart';

import '../../../../core/enums/status.dart';
import '../../../../core/global/routes/app_routes.dart';
import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/app_assets.dart';

class BuildPopularWidget extends StatelessWidget {
  BuildPopularWidget({super.key});
  final controller = Get.find<MoviesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.rxPopularRequestStatus.value) {
        case Status.loading:
          return SizedBox.fromSize();
        case Status.complete:
          return Padding(
            padding: EdgeInsetsDirectional.only(
                end: AppSizes.pW16, top: AppSizes.pH10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText.bodyMedium('Popular', context: context),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.resetCurrentPage(1);
                            Get.to(() => MorePopular(),
                                arguments: controller.popularMovies,
                                transition: Transition.downToUp);
                          },
                          child: SvgPicture.asset(
                            AppAssets.menuDots,
                            width: AppSizes.iconSize,
                            // ignore: deprecated_member_use
                            color: ThemeColor.orangeColor,
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.pW8,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSizes.pH10,
                ),
                SizedBox(
                  height: AppSizes.pH130,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final popular = controller.popularMovies[index];
                      return MoviesInfoWidget(
                          goToTrailer: () => Get.toNamed(
                                RoutesPath.trailerScreen,
                                arguments: popular.id,
                              ),
                          onTap: () => Get.toNamed(
                                RoutesPath.detailsScreen,
                                arguments: popular.id,
                              ),
                          title: popular.title,
                          image: popular.backdropPath!,
                          voteAverage: popular.voteAverage);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: AppSizes.pW6,
                      );
                    },
                    itemCount: controller.popularMovies.length,
                  ),
                )
              ],
            ),
          );
        case Status.error:
          return SizedBox.fromSize();
      }
    });
  }
}

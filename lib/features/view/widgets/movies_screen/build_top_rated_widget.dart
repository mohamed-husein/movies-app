import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/global/routes/app_routes.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../logic/controller/movies_controller.dart';
import 'more_top_rated.dart';
import 'movies_info_widget.dart';

import '../../../../core/enums/status.dart';
import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/app_assets.dart';

class BuildTopRatedWidget extends StatelessWidget {
  BuildTopRatedWidget({super.key});
  final controller = Get.find<MoviesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.rxTopRatedRequestStatus.value) {
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSizes.pH12, bottom: AppSizes.pH10),
                      child:
                          CustomText.bodyMedium('Top Rated', context: context),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.resetCurrentPage(1);
                            Get.to(() => MoreTopRated(),
                                arguments: controller.topRated,
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
                      final topRated = controller.topRated[index];
                      return MoviesInfoWidget(
                          goToTrailer: () => Get.toNamed(
                              RoutesPath.trailerScreen,
                              arguments: topRated.id),
                          onTap: () => Get.toNamed(
                                RoutesPath.detailsScreen,
                                arguments: topRated.id,
                              ),
                          title: topRated.title,
                          image: topRated.backdropPath!,
                          voteAverage: topRated.voteAverage);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: AppSizes.pW6,
                      );
                    },
                    itemCount: 8,
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

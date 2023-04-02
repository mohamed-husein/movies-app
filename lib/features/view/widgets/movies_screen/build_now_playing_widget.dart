// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movies/core/global/routes/app_routes.dart';
import 'package:movies/core/global/theme/theme_color/theme_color_dark.dart';
import 'package:movies/core/utils/api_constants.dart';
import 'package:movies/core/utils/app_sizes.dart';
import 'package:movies/core/utils/custom_text.dart';
import 'package:movies/features/logic/controller/movies_controller.dart';

import '../../../../core/enums/status.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/blur_container.dart';

class BuildNowPlayingWidget extends StatelessWidget {
  BuildNowPlayingWidget({super.key});
  final controller = Get.find<MoviesController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.rxNowPlayingRequestStatus.value) {
          case Status.loading:
            return SizedBox.fromSize();
          case Status.complete:
            return CarouselSlider.builder(
              itemCount: controller.nowPlayingMovies.length,
              itemBuilder: (context, index, realIndex) {
                final nowPlaying = controller.nowPlayingMovies[index];
                return GestureDetector(
                  onTap: () => Get.toNamed(RoutesPath.detailsScreen,
                      arguments: nowPlaying.id),
                  child: Container(
                    height: AppSizes.pH150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          ApiConstants.imageUrl(
                            nowPlaying.backdropPath,
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.br20),
                    ),
                    margin: EdgeInsetsDirectional.only(
                      top: AppSizes.pH12,
                      bottom: AppSizes.pH12,
                      end: AppSizes.pW16,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 15,
                          right: 15,
                          child: BlurContainer(
                            height: AppSizes.pH22,
                            width: AppSizes.pW45,
                            raduis: AppSizes.br30,
                            child: Center(
                              child: CustomText.bodySmall(
                                  '${index + 1}/${controller.nowPlayingMovies.length}',
                                  context: context),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 15,
                          left: 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: AppSizes.widthFullScreen / 2,
                                    child: CustomText.bodyMedium(
                                      nowPlaying.title,
                                      context: context,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: AppSizes.pW6,
                                      ),
                                      CustomText.bodySmall(
                                          '${nowPlaying.voteAverage}',
                                          context: context)
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => Get.toNamed(
                                    RoutesPath.trailerScreen,
                                    arguments: nowPlaying.id),
                                child: BlurContainer(
                                  height: AppSizes.pH55,
                                  width: AppSizes.pW60,
                                  raduis: AppSizes.br30,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ThemeColor.white,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AppAssets.play,
                                        width: AppSizes.iconSize,
                                        color: ThemeColor.orangeColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            );
          case Status.error:
            return SizedBox.fromSize();
        }
      },
    );
  }
}

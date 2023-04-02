import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/enums/status.dart';
import '../../../core/global/routes/app_routes.dart';
import '../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../core/utils/api_constants.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/custom_text.dart';
import '../../../core/widgets/blur_container.dart';
import '../../logic/controller/details_controller.dart';
import '../../logic/controller/fav_controller.dart';
import '../../model/favorites_model.dart';
import '../../model/genres_model.dart';
import '../widgets/details_screen/build_crew_widget.dart';
import '../widgets/details_screen/build_recommended_widget.dart';

class DetailsScreen extends GetView<DetailsController> {
  DetailsScreen({super.key});

  final favCtrl = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.rxDetailsRequestStatus.value) {
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
            return SafeArea(
              child: Scaffold(
                body: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: AppSizes.pH250,
                          width: AppSizes.widthFullScreen,
                          child: Image.network(
                            fit: BoxFit.fill,
                            ApiConstants.imageUrl(
                                controller.moviesDetails.value.backdropPath),
                          ),
                        ),
                        Positioned(
                          top: AppSizes.pH8,
                          child: SizedBox(
                            width: AppSizes.widthFullScreen,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: ThemeColor.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final favorite =
                                        controller.moviesDetails.value;
                                    favCtrl.addFavorites(
                                      Favorites(
                                        id: favorite.id!,
                                        title: favorite.title!,
                                        voteAverage: favorite.voteAverage!,
                                        backdropPath: favorite.backdropPath!,
                                        posterPath: favorite.poster!,
                                      ),
                                    );
                                  },
                                  icon: Obx(
                                    () => Icon(
                                      Icons.favorite,
                                      color: favCtrl.inFav(controller
                                              .moviesDetails.value.id!)
                                          ? ThemeColor.errorColor
                                          : ThemeColor.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: AppSizes.pH15,
                          child: BlurContainer(
                            width: AppSizes.pW160,
                            raduisOnly: true,
                            topLeft: AppSizes.br30,
                            bottomLeft: AppSizes.br30,
                            height: AppSizes.pH50,
                            child: GestureDetector(
                              onTap: () => Get.toNamed(RoutesPath.trailerScreen,
                                  arguments:
                                      controller.moviesDetails.value.id!),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: AppSizes.pW8),
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
                                        // ignore: deprecated_member_use
                                        color: ThemeColor.orangeColor,
                                      ),
                                    ),
                                  ),
                                  CustomText.displayLarge('Watch Trailar',
                                      context: context)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: AppSizes.pH14, bottom: AppSizes.pH8),
                      child: CustomText.displayMedium(
                        controller.moviesDetails.value.title!,
                        textAlign: TextAlign.center,
                        context: context,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: AppSizes.pH8),
                      child: CustomText.labelSmall(
                          '${_showGenres(controller.moviesDetails.value.genres!)} | ${_showDuration(controller.moviesDetails.value.runtime!)}',
                          context: context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.pW75),
                      child: Divider(
                        thickness: 3.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.pW16, vertical: AppSizes.pH10),
                      child: CustomText.bodyMedium(
                        'Story Line',
                        context: context,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: AppSizes.pW16,
                          left: AppSizes.pW16,
                          bottom: AppSizes.pH22),
                      child: CustomText.labelSmall(
                        controller.moviesDetails.value.overView!,
                        context: context,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    controller.crew.isEmpty
                        ? Container()
                        : Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: AppSizes.pW16, bottom: AppSizes.pH12),
                            child: CustomText.bodyMedium(
                              'Star cast',
                              context: context,
                              textAlign: TextAlign.start,
                            ),
                          ),
                    CrewWidget(
                        crew: controller.crew.isEmpty ? [] : controller.crew),
                    controller.recommendedMovies.isEmpty
                        ? Container()
                        : Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: AppSizes.pW16,
                                bottom: AppSizes.pH12,
                                top: AppSizes.pH12),
                            child: CustomText.bodyMedium(
                              'Recommended',
                              context: context,
                              textAlign: TextAlign.start,
                            ),
                          ),
                    RecommendedMoviesWidget(
                        recommendedMovies: controller.recommendedMovies.isEmpty
                            ? []
                            : controller.recommendedMovies),
                  ],
                ),
              ),
            );

          case Status.error:
            return Text(
              controller.error.value,
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

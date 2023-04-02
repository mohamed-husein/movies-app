// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/core/global/routes/app_routes.dart';
import 'package:movies/core/global/theme/theme_color/theme_color_dark.dart';
import 'package:movies/core/utils/app_sizes.dart';
import 'package:movies/features/logic/controller/movies_controller.dart';
import 'package:movies/features/view/widgets/movies_screen/build_genres_tabs.dart';
import 'package:movies/features/view/widgets/movies_screen/build_header.dart';
import 'package:movies/features/view/widgets/movies_screen/build_search_widget.dart';
import 'package:movies/features/view/widgets/movies_screen/build_top_rated_widget.dart';
import 'package:movies/features/view/widgets/movies_screen/movies_info_widget.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/enums/status.dart';
import '../../../core/utils/app_assets.dart';
import '../widgets/movies_screen/build_now_playing_widget.dart';
import '../widgets/movies_screen/build_popular_widget.dart';

class MoviesScreen extends GetView<MoviesController> {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(
            () {
              switch (controller.rxRequestStatus.value) {
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
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppSizes.pW16,
                    ),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          const BuildMoviesHeader(),
                          if (controller.moviesByQuery.isEmpty) ...[
                            const BuildSearchWidget(),
                            SizedBox(
                              height: AppSizes.pH8,
                            ),
                            controller.isSearch.value == true
                                ? Container()
                                : const BuildGenresTabs(),
                            SizedBox(
                              height: AppSizes.pH6,
                            ),
                            if (controller.moviesByGenres.isEmpty) ...[
                              // *** Home Screen

                              BuildNowPlayingWidget(),
                              BuildPopularWidget(),
                              BuildTopRatedWidget(),
                              SizedBox(
                                height: AppSizes.pH55,
                              )
                              // *** Home Screen
                            ] else ...[
                              Obx(
                                () {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: AppSizes.pW16,
                                            top: AppSizes.pH8),
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemCount:
                                              controller.moviesByGenres.length,
                                          itemBuilder: (context, index) {
                                            return MoviesInfoWidget(
                                                goToTrailer: () => Get.toNamed(
                                                    RoutesPath.trailerScreen,
                                                    arguments: controller
                                                        .moviesByGenres[index]
                                                        .id),
                                                onTap: () => Get.toNamed(
                                                    RoutesPath.detailsScreen,
                                                    arguments: controller
                                                        .moviesByGenres[index]
                                                        .id),
                                                title: controller
                                                    .moviesByGenres[index]
                                                    .title,
                                                image: controller
                                                    .moviesByGenres[index]
                                                    .posterPath!,
                                                voteAverage: controller
                                                    .moviesByGenres[index]
                                                    .voteAverage);
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: AppSizes.pW16,
                                            mainAxisSpacing: AppSizes.pH10,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: AppSizes.pH16,
                                            bottom: AppSizes.pH10,
                                            right: AppSizes.pW16),
                                        child: NumberPaginator(
                                          numberPages:
                                              controller.moviesByGenres.length,
                                          initialPage:
                                              controller.currentPage.value - 1,
                                          onPageChange: (index) => controller
                                              .changeCurrentPage(index + 1),
                                          config: NumberPaginatorUIConfig(
                                            height: AppSizes.pH35,
                                            buttonSelectedForegroundColor:
                                                ThemeColor.white,
                                            buttonUnselectedForegroundColor:
                                                Colors.white,
                                            buttonUnselectedBackgroundColor:
                                                Colors.grey.shade900
                                                    .withOpacity(.9),
                                            buttonSelectedBackgroundColor:
                                                ThemeColor.orangeColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppSizes.pH60,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ]
                        ],
                      ),
                    ),
                  );
                case Status.error:
                  return Text(controller.error.toString());
              }
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/global/routes/app_routes.dart';
import '../../../core/utils/custom_text.dart';
import '../../logic/controller/trending_controller.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../core/enums/status.dart';
import '../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_sizes.dart';
import '../widgets/movies_screen/movies_info_widget.dart';

class TrendingScreen extends GetView<TrendingController> {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.rxTrendingRequestStatus.value) {
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
            return Scaffold(
              appBar: AppBar(
                title:
                    CustomText.bodyMedium('Trending Movies', context: context),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.pW16,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.trendingMovies.length,
                        itemBuilder: (context, index) {
                          final data = controller.trendingMovies;
                          return MoviesInfoWidget(
                            onTap: () {
                              Get.toNamed(RoutesPath.detailsScreen,
                                  arguments: data[index].id);
                            },
                            title: data[index].title,
                            image: data[index].posterPath!,
                            voteAverage: data[index].voteAverage,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                        numberPages: controller.trendingMovies.length,
                        initialPage: controller.currentPage.value - 1,
                        onPageChange: (index) =>
                            controller.getMoreTrendingMovies(index + 1),
                        config: NumberPaginatorUIConfig(
                          height: AppSizes.pH35,
                          buttonSelectedForegroundColor: ThemeColor.white,
                          buttonUnselectedForegroundColor: Colors.white,
                          buttonUnselectedBackgroundColor:
                              Colors.grey.shade900.withOpacity(.9),
                          buttonSelectedBackgroundColor: ThemeColor.orangeColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.pH60,
                    )
                  ],
                ),
              ),
            );
          case Status.error:
            return CustomText.bodyMedium(controller.error.value,
                context: context);
        }
      },
    );
  }
}

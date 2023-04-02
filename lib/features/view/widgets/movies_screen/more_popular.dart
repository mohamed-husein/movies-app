import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../logic/controller/movies_controller.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../model/movies_model.dart';
import 'movies_info_widget.dart';

class MorePopular extends StatelessWidget {
  MorePopular({super.key});

  final List<Movies> data = Get.arguments;

  final controller = Get.find<MoviesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              controller.resetCurrentPage(1);
              controller.getMorePopularMovies(1);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeColor.white,
            )),
        title: CustomText.bodyMedium('Popular Movies', context: context),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(right: AppSizes.pW16, top: AppSizes.pH8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MoviesInfoWidget(
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
                  numberPages: data.length,
                  initialPage: controller.currentPage.value - 1,
                  onPageChange: (index) =>
                      controller.getMorePopularMovies(index + 1),
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
            ],
          ),
        ),
      ),
    );
  }
}

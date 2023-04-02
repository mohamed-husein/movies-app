import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/global/routes/app_routes.dart';
import '../../../logic/controller/details_controller.dart';

import '../../../../core/utils/app_sizes.dart';
import '../../../model/movies_model.dart';
import '../movies_screen/movies_info_widget.dart';

class RecommendedMoviesWidget extends GetView<DetailsController> {
  const RecommendedMoviesWidget({super.key, required this.recommendedMovies});

  final List<Movies> recommendedMovies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: AppSizes.pW16, bottom: AppSizes.pH12),
      child: SizedBox(
        height: AppSizes.pH130,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final recommeded = recommendedMovies[index];

            return MoviesInfoWidget(
                onTap: () {
                  Get.toNamed(
                    RoutesPath.detailsScreen,
                    arguments: recommeded.id,
                  );
                },
                goToTrailer: () => Get.toNamed(
                      RoutesPath.trailerScreen,
                      arguments: recommeded.id,
                    ),
                title: recommeded.title,
                image: recommeded.backdropPath!,
                voteAverage: recommeded.voteAverage.round().toDouble());
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: AppSizes.pW12,
            );
          },
          itemCount: recommendedMovies.length,
        ),
      ),
    );
  }
}

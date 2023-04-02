import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../logic/controller/fav_controller.dart';

import '../../../core/global/routes/app_routes.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/custom_text.dart';
import '../widgets/movies_screen/movies_info_widget.dart';

class FavouritesScreen extends GetView<FavoritesController> {
  FavouritesScreen({super.key});

  final favCtrl = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText.bodyMedium('Favorites Movies', context: context),
      ),
      body: Obx(
        () {
          if (controller.favs.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.pW16),
              child: Center(
                child: CustomText.bodyMedium(
                    'No Favorites Added, please add your Favorites to see here ..',
                    context: context),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(
                top: AppSizes.pH10, left: AppSizes.pW16, right: AppSizes.pW16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favCtrl.favs.length,
                    itemBuilder: (context, index) {
                      final data = favCtrl.favs;
                      return MoviesInfoWidget(
                        onTap: () => Get.toNamed(
                          RoutesPath.detailsScreen,
                          arguments: data[index].id,
                        ),
                        title: data[index].title,
                        image: data[index].posterPath,
                        voteAverage: data[index].voteAverage,
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSizes.pW16,
                      mainAxisSpacing: AppSizes.pH10,
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.pH60,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

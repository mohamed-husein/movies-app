import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controller/movies_controller.dart';

import '../../../../core/enums/status.dart';
import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/custom_text.dart';

class BuildGenresTabs extends GetView<MoviesController> {
  const BuildGenresTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.rxRequestStatus.value) {
        case Status.loading:
          return Container();
        case Status.complete:
          return SizedBox(
            height: AppSizes.pH32,
            width: AppSizes.widthFullScreen,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  height: AppSizes.pH32,
                  child: GetBuilder<MoviesController>(
                    builder: (_) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            controller.currentIndex != -1
                                ? ThemeColor.backgroundColor
                                : ThemeColor.orangeColor,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            ThemeColor.orangeColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.br8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          controller.resetIndex();
                        },
                        child: controller.currentIndex != -1
                            ? CustomText.labelSmall(
                                'All',
                                context: context,
                              )
                            : CustomText.bodySmall(
                                'All',
                                context: context,
                              ),
                      );
                    },
                  ),
                ),
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.changeIndex(index),
                      child: GetBuilder<MoviesController>(
                        builder: (_) => Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: AppSizes.pW12),
                          margin:
                              EdgeInsets.symmetric(horizontal: AppSizes.pW3),
                          decoration: BoxDecoration(
                            color: controller.currentIndex == index
                                ? ThemeColor.orangeColor
                                : null,
                            borderRadius: BorderRadius.circular(
                              AppSizes.br8,
                            ),
                          ),
                          child: Center(
                            child: controller.currentIndex == index
                                ? CustomText.bodySmall(
                                    controller.genres[index].name,
                                    context: context)
                                : CustomText.labelSmall(
                                    controller.genres[index].name,
                                    context: context,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.genres.length,
                ),
              ],
            ),
          );
        case Status.error:
          return Container();
      }
    });
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movies/features/logic/controller/movies_controller.dart';

import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/custom_text.dart';

class BuildSearchWidget extends GetView<MoviesController> {
  const BuildSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.widthFullScreen,
      height: AppSizes.pH60,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {
                if (controller.editController.text.isEmpty) {
                  controller.resetIndex();
                }
              },
              onSubmitted: (value) {
                controller.getMoviesByQuery(value);
              },
              controller: controller.editController,
              style: TextStyle(
                color: ThemeColor.labelColor,
                fontSize: AppSizes.fs13,
              ),
              cursorColor: ThemeColor.labelColor,
              decoration: const InputDecoration(hintText: 'Search Movies ... '),
            ),
          ),
          SizedBox(
            width: AppSizes.pW12,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: AppSizes.pW16,
            ),
            child: GestureDetector(
              onTap: () => Get.defaultDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.pW8),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: controller.yearController,
                        style: TextStyle(
                          color: ThemeColor.labelColor,
                          fontSize: AppSizes.fs13,
                        ),
                        cursorColor: ThemeColor.labelColor,
                        decoration: const InputDecoration(
                            hintText: 'Enter the year ... '),
                      ),
                      Wrap(
                        children: List.generate(
                          controller.genres.length,
                          (index) => Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: AppSizes.pW10, bottom: 0),
                            child: Obx(
                              () => ChoiceChip(
                                selectedColor: ThemeColor.orangeColor,
                                label: CustomText.bodySmall(
                                  controller.genres[index].name,
                                  context: context,
                                ),
                                selected: controller.genres[index].isChecked,
                                onSelected: (value) {
                                  controller.selectFilter(index);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (controller.filterSearch.isNotEmpty) ...[
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Colors.grey.shade900.withOpacity(.9)),
                                    foregroundColor: MaterialStateProperty.all<
                                            Color>(
                                        Colors.grey.shade900.withOpacity(.9)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.br8),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.resetIndex();

                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppSizes.pW12),
                                    child: CustomText.bodySmall(
                                      'Clear',
                                      context: context,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AppSizes.pW6,
                                )
                              ],
                            ),
                          ],
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                ThemeColor.orangeColor,
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                ThemeColor.orangeColor,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.br8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              controller.getMoviesByGenres(
                                controller.filterSearch.join(','),
                                controller.yearController.text,
                                '1',
                              );

                              Get.back();
                            },
                            child: CustomText.bodySmall(
                              'Confirm',
                              context: context,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                title: 'Filter Search',
                titleStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              child: Container(
                width: AppSizes.pW50,
                height: AppSizes.pH45,
                decoration: BoxDecoration(
                    color: ThemeColor.orangeColor,
                    borderRadius: BorderRadius.circular(AppSizes.br10)),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.filter,
                    width: AppSizes.iconSize,
                    color: ThemeColor.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

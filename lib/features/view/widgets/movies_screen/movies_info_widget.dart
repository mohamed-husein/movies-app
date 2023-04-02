// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/api_constants.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_sizes.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../../core/widgets/blur_container.dart';

class MoviesInfoWidget extends StatelessWidget {
  const MoviesInfoWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.voteAverage,
      this.onTap,
      this.goToTrailer});
  final String title;
  final String image;
  final double voteAverage;
  final VoidCallback? onTap;
  final VoidCallback? goToTrailer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.pH130,
        width: AppSizes.widthHalfScreen,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              ApiConstants.imageUrl(
                image,
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(AppSizes.br20),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: BlurContainer(
                raduisOnly: true,
                bottomRight: AppSizes.br25,
                bottomLeft: AppSizes.br20,
                width: AppSizes.widthHalfScreen,
                height: AppSizes.pH45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: AppSizes.pH4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: AppSizes.pW10,
                          ),
                          SizedBox(
                            width: AppSizes.widthQuarterScreen,
                            child: CustomText.bodySmall(
                              title,
                              context: context,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: AppSizes.pW10,
                        ),
                        const Icon(
                          Icons.star_border_outlined,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: AppSizes.pW6,
                        ),
                        CustomText.bodySmall('$voteAverage', context: context)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: AppSizes.pH32,
              right: AppSizes.pW16,
              child: GestureDetector(
                onTap: goToTrailer,
                child: Container(
                  width: AppSizes.pW32,
                  height: AppSizes.pH27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.br8),
                    color: ThemeColor.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        AppAssets.play,
                        width: AppSizes.iconSize,
                        color: ThemeColor.orangeColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

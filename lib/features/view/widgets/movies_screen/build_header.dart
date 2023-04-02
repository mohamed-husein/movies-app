// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_sizes.dart';

class BuildMoviesHeader extends StatelessWidget {
  const BuildMoviesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: AppSizes.pH15,
          bottom: AppSizes.pH15,
          start: AppSizes.pH4,
          end: AppSizes.pW16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            AppAssets.menu,
            width: AppSizes.iconSize,
            color: ThemeColor.white,
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.notifications,
                width: AppSizes.iconSize,
                color: ThemeColor.white,
              ),
              SizedBox(
                width: AppSizes.pW12,
              ),
              SvgPicture.asset(
                AppAssets.menuDots,
                width: AppSizes.iconSize,
                color: ThemeColor.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

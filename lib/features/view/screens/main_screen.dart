import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/global/theme/theme_color/theme_color_dark.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/utils/custom_text.dart';
import '../../../core/widgets/blur_container.dart';
import '../../logic/controller/main_controller.dart';
import 'favourites_screen.dart';
import 'movies_screen.dart';
import 'trending_screen.dart';

class BottomNavItem {
  final String icon;

  BottomNavItem({
    required this.icon,
  });
}

class MainScreen extends GetView<MainController> {
  MainScreen({super.key});

  final List<BottomNavItem> selectedItems = [
    BottomNavItem(
      icon: AppAssets.selectedHome,
    ),
    BottomNavItem(
      icon: AppAssets.selectedTrending,
    ),
    BottomNavItem(
      icon: AppAssets.selectedHeart,
    ),
  ];
  final List<BottomNavItem> unselectedItems = [
    BottomNavItem(
      icon: AppAssets.unSelectedHome,
    ),
    BottomNavItem(
      icon: AppAssets.unSelectedTrending,
    ),
    BottomNavItem(
      icon: AppAssets.unSelectedHeart,
    ),
  ];

  final List<String> tabTitle = ['Home', 'Trending', 'Favorites'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.heightFullScreen,
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              body: IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  const MoviesScreen(),
                  const TrendingScreen(),
                  FavouritesScreen(),
                ],
              ),
            ),
            Positioned(
              bottom: AppSizes.pH8,
              right: AppSizes.pW16,
              left: AppSizes.pW16,
              child: BlurContainer(
                height: AppSizes.pH60,
                raduis: AppSizes.br10,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(selectedItems.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectItem(index);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSizes.pW12),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                height: AppSizes.pH18,
                                child: SvgPicture.asset(
                                  controller.currentIndex.value == index
                                      ? selectedItems[index].icon
                                      : unselectedItems[index].icon,

                                  width: AppSizes.iconSize,
                                  // ignore: deprecated_member_use
                                  color: controller.currentIndex.value == index
                                      ? ThemeColor.orangeColor
                                      : ThemeColor.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppSizes.pH4,
                            ),
                            controller.currentIndex.value == index
                                ? CustomText.displaySmall(
                                    tabTitle[index],
                                    context: context,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                          fontSize: AppSizes.fs11,
                                        ),
                                  )
                                : CustomText.bodySmall(
                                    tabTitle[index],
                                    context: context,
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: AppSizes.fs11,
                                        ),
                                  ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_fonsts.dart';
import '../../../utils/app_sizes.dart';
import '../theme_color/theme_color_dark.dart';

ThemeData get getThemeData => ThemeData(
      primaryColor: ThemeColor.backgroundColor,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ThemeColor.backgroundColor,
      fontFamily: AppFonts.fontFamily,
      appBarTheme: const AppBarTheme(
          backgroundColor: ThemeColor.backgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ThemeColor.black),
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: ThemeColor.backgroundColor,
            statusBarColor: ThemeColor.backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.white,
            //Navigation bar divider color
            systemNavigationBarIconBrightness:
                Brightness.light, //navigation bar icon
          )),

      /// TextFormField
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: ThemeColor.labelColor,
          fontSize: AppSizes.fs13,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSizes.bs0_5,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br12),
        ),
        suffixIconColor: ThemeColor.labelMediumColor,
        filled: true,
        fillColor: Colors.grey.shade900.withOpacity(.9),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSizes.bs0_5,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSizes.bs0_5,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br12),
        ),
        errorStyle: TextStyle(
          color: ThemeColor.validationTextFieldColor,
          fontSize: AppSizes.fs14,
          fontWeight: AppFonts.regular,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: AppSizes.bs0_5,
          ),
          borderRadius: BorderRadius.circular(AppSizes.br12),
        ),
        labelStyle: TextStyle(
          color: ThemeColor.black,
          fontSize: AppSizes.fs13,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ThemeColor.orangeColor,
          ),
          // padding: MaterialStateProperty.all(
          //   EdgeInsets.symmetric(
          //     vertical: AppSizes.pH12,
          //     horizontal: AppSizes.pW22,
          //   ),
          // ),
          foregroundColor: MaterialStateProperty.all<Color>(
            ThemeColor.orangeColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.br8),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.br40),
            ),
          ),
          overlayColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
      ),
      textTheme: getTextTheme(),
      tabBarTheme: TabBarTheme(
        // labelPadding: const EdgeInsets.only(left: 0, right: 15),
        labelColor: ThemeColor.white,
        labelStyle: TextStyle(
          color: ThemeColor.white,
          fontSize: AppSizes.fs11,
          fontWeight: AppFonts.semiBlod,
          fontFamily: AppFonts.fontFamily,
        ),
        unselectedLabelStyle: TextStyle(
          color: ThemeColor.darkGrey,
          fontSize: AppSizes.fs11,
          fontWeight: AppFonts.semiBlod,
          fontFamily: AppFonts.fontFamily,
        ),
        unselectedLabelColor: ThemeColor.darkGrey,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: CircleTabInicator(
          color: ThemeColor.white,
          radius: AppSizes.br4,
        ),
      ),
    );

getTextTheme() => TextTheme(
      /// Primary Color Light
      displaySmall: TextStyle(
        color: ThemeColor.orangeColor,
        fontSize: AppSizes.fs13,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),

      /// Primary Color AppBar
      displayMedium: TextStyle(
        color: ThemeColor.white,
        fontSize: AppSizes.fs20,
        fontWeight: AppFonts.bold,
        fontFamily: AppFonts.fontFamily,
      ),
      displayLarge: TextStyle(
        color: ThemeColor.orangeColor,
        fontSize: AppSizes.fs13,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),

      headlineLarge: TextStyle(
        color: ThemeColor.grayscale,
        fontSize: AppSizes.fs48,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.fontFamily,
      ),
      headlineMedium: TextStyle(
        color: ThemeColor.grayscale,
        fontSize: AppSizes.fs32,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.fontFamily,
      ),
      headlineSmall: TextStyle(
        color: ThemeColor.labelColor,
        fontSize: AppSizes.fs11,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),

      /// Body For Text in Black Color
      bodySmall: TextStyle(
        color: ThemeColor.white,
        fontSize: AppSizes.fs13,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),
      bodyMedium: TextStyle(
        color: ThemeColor.white,
        fontSize: AppSizes.fs18,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),
      bodyLarge: TextStyle(
        color: ThemeColor.black,
        fontSize: AppSizes.fs20,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.fontFamily,
      ),

      /// Title
      titleSmall: TextStyle(
        color: ThemeColor.white,
        fontSize: AppSizes.fs13,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),

      /// White Text For Button
      titleMedium: TextStyle(
        color: ThemeColor.white,
        fontSize: AppSizes.fs14,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),
      titleLarge: TextStyle(
        color: ThemeColor.white,
        fontSize: AppSizes.fs18,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.fontFamily,
      ),

      /// Label For Color Grey
      labelSmall: TextStyle(
        color: ThemeColor.labelColor,
        fontSize: AppSizes.fs11,
        fontWeight: AppFonts.semiBlod,
        fontFamily: AppFonts.fontFamily,
      ),

      labelMedium: TextStyle(
        color: ThemeColor.labelColor,
        fontSize: AppSizes.fs16,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.fontFamily,
      ),

      labelLarge: TextStyle(
        color: ThemeColor.labelColor,
        fontSize: AppSizes.fs18,
        fontWeight: AppFonts.regular,
        fontFamily: AppFonts.fontFamily,
      ),
    );

class CircleTabInicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabInicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}

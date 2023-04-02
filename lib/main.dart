import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/global/routes/app_routes.dart';
import 'core/global/theme/theme_data/dark.dart';
import 'core/utils/app_constants.dart';
import 'features/services/storage_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageServices().init());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstance.title,
          theme: getThemeData,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1,
              ),
              child: child!,
            );
          },
          getPages: AppRoutes.routes,
          initialRoute: RoutesPath.initial,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siscom_mobile/app/routes/app_pages.dart';
import 'package:siscom_mobile/app/utils/constants/app_const.dart';
import 'package:siscom_mobile/app/utils/themes/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load();
  } catch (e) {
    debugPrint('Warning: .env file not found or failed to load: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: AppConst.deviceSize,
      builder:(context,child) {
      return GetMaterialApp(
        title: 'SISCOM',
        getPages: AppPages.routes,
        initialRoute: AppPages.INITIAL,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      );
      }
    );
  }
}

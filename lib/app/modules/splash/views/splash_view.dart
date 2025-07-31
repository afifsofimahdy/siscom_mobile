// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:siscom_mobile/app/modules/splash/controllers/splash_controller.dart';
import 'package:siscom_mobile/app/utils/constants/app_images.dart';
import 'package:siscom_mobile/app/utils/themes/colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRect(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Image.asset(AppImages.logoText),
              ),
            ),
            20.verticalSpace,
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
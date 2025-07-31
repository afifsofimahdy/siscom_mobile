// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siscom_mobile/app/utils/themes/colors.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.lightBackground,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(fontFamily: 'Poppins', fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
      displayMedium: TextStyle(fontFamily: 'Poppins', fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
      displaySmall: TextStyle(fontFamily: 'Poppins', fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
      headlineMedium: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.textDark),
      headlineSmall: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.textDark),
      titleLarge: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textDark),
      bodyLarge: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: AppColors.textDark),
      bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 12.sp, color: AppColors.textDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        textStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w600),
      ),
    ),
  );

}
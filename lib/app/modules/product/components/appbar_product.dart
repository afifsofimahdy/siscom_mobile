// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:siscom_mobile/app/utils/themes/colors.dart';

class AppBarProduct extends StatelessWidget {
  final TextEditingController searchController;
  const AppBarProduct({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Container(
        height: 70.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.textLight,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: SizedBox(
                height: 54.h,
                width: 0.8.sw,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        LineIcons.search,
                        size: 24.sp,
                        color: AppColors.textGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.7)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: AppColors.primaryColor.withOpacity(0.7)),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                    ),
                  ),
                ),
              ),
            ),
            Icon(
              LineIcons.filter,
              size: 28.sp,
              color: AppColors.textGrey,
            )
          ],
        ),
      ),
    );
  }
}
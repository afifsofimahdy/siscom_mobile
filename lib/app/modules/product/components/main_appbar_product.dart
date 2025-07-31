// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:siscom_mobile/app/modules/product/components/appbar_product.dart';
import 'package:siscom_mobile/app/utils/constants/app_images.dart';
import 'package:siscom_mobile/app/utils/themes/colors.dart';

class MainAppBarProduct extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onAddPressed;
  final TextEditingController searchController; 
  
  const MainAppBarProduct({
    super.key,
    this.onAddPressed,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: AppColors.primaryColor,
      title: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Image.asset(AppImages.logoText),
      ),
      actions: [
        SizedBox(
          height: 40.h,
          width: 120.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonSecondary.withOpacity(0.8),
              foregroundColor: AppColors.textLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            onPressed: onAddPressed ?? () {
              // Handle add button press
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_box_outlined,
                  size: 22.sp,
                ),
                4.horizontalSpace,
                Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          )
        ),
        8.horizontalSpace
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(100.h), 
        child: AppBarProduct(
          searchController: searchController,
        )
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(160.h); 
}
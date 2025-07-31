// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardsProducts extends StatelessWidget {
  const ShimmerCardsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: ShimmerCardProduct(),
        );
      },
    );
  }
}

class ShimmerCardProduct extends StatelessWidget {
  const ShimmerCardProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
        ],
      ),
      child: Row(
        children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey.shade300,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          flex: 3,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            height: 16.h,
            width: double.infinity,
            color: Colors.grey.shade300,
            ),
            SizedBox(height: 4.h),
            Container(
            height: 14.h,
            width: 80.w,
            color: Colors.grey.shade300,
            ),
          ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
          height: 16.h,
          width: 60.w,
          color: Colors.grey.shade300,
          ),
        ),
        ],
      ),
      ),
    );
  }
}
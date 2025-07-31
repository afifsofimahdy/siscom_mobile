// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:siscom_mobile/app/data/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailBottomSheet extends StatelessWidget {
  final Product product;

  const ProductDetailBottomSheet({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  height: 150.h,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Icon(Icons.image_not_supported, size: 50.sp),
                ),
                placeholder: (context, url) => Container(
                  height: 150.h,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed('/product/edit', arguments: product),
                icon: Icon(Icons.edit, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Tags: ${product.groupItem} || Category: ${product.category?.name ?? '-'}  ',
            style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stock',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                  ),
                  Text(
                    '${product.stock ?? 0}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                  ),
                  Text(
                    'Rp ${product.price?.toString() ?? '0'}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            product.description ?? 'No description available',
            style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

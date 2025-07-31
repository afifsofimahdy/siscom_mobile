import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardProduct extends StatelessWidget {
  final String productName;
  final int stock;
  final double price;
  final bool isSelected;
  final Function(bool?)? onChanged;
  final VoidCallback? onTap;

  const CardProduct({
    super.key,
    required this.productName,
    required this.stock,
    required this.price,
    this.isSelected = false,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  onTap,
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
              ),
              child: Checkbox(
                value: isSelected,
                onChanged: onChanged,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Stok : $stock',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Rp ${price.toStringAsFixed(0)}',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
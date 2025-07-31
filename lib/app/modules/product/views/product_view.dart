// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:siscom_mobile/app/modules/product/components/card_product.dart';
import 'package:siscom_mobile/app/modules/product/components/main_appbar_product.dart';
import 'package:siscom_mobile/app/modules/product/components/shimmer_cards_product.dart';
import 'package:siscom_mobile/app/modules/product/controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarProduct(
        searchController: controller.searchController,
        onAddPressed: () {},
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Obx(
          () {
            final isSearching = controller.searchController.text.isNotEmpty;
            final products = isSearching
                ? controller.filteredProducts
                : controller.products;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.verticalSpace,
                if (controller.isLoading.value)
                  Center(child: CircularProgressIndicator())
                else
                  Text("${products.length} Data Ditemukan"),
                10.verticalSpace,
                Expanded(
                  child: controller.isLoading.value
                      ? ShimmerCardsProducts()
                      : RefreshIndicator(
                          onRefresh: () async {
                            await controller.fetchProducts(reset: true);
                          },
                          child: products.isEmpty
                              ? Center(
                                  child: Text('No products found'),
                                )
                              : ListView.builder(
                                  controller: controller.scrollController,
                                  itemCount: products.length +
                                      (controller.hasMoreData.value ? 1 : 0),
                                  itemBuilder: (context, index) {
                                    if (index == products.length &&
                                        controller.hasMoreData.value) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.w),
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    final product = products[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: CardProduct(
                                        productName: product.name,
                                        stock: product.stock,
                                        price: product.price.toDouble(),
                                        onTap: () =>
                                            controller.getProductById(product.id),
                                      ),
                                    );
                                  },
                                ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
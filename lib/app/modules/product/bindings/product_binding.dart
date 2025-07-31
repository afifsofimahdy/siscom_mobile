import 'package:get/get.dart';
import 'package:siscom_mobile/app/data/repositories/category/category_repository.dart';
import 'package:siscom_mobile/app/data/repositories/product/product_repository.dart';
import 'package:siscom_mobile/app/modules/product/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<CategoryRepository>(() => CategoryRepository());
  }
}
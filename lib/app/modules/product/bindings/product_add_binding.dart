import 'package:get/get.dart';
import 'package:siscom_mobile/app/data/repositories/category/category_repository.dart';
import 'package:siscom_mobile/app/data/repositories/product/product_repository.dart';
import 'package:siscom_mobile/app/modules/product/controllers/product_add_controller.dart';


class ProductAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductAddController>(() => ProductAddController());
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<CategoryRepository>(() => CategoryRepository());
  }
}
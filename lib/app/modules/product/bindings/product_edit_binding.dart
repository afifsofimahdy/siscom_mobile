import 'package:get/get.dart';
import 'package:siscom_mobile/app/data/repositories/category/category_repository.dart';
import 'package:siscom_mobile/app/data/repositories/product/product_repository.dart';
import 'package:siscom_mobile/app/modules/product/controllers/product_edit_controller.dart';


class ProductEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductEditController>(() => ProductEditController());
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<CategoryRepository>(() => CategoryRepository());
  }
}
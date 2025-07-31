import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siscom_mobile/app/data/models/category_model.dart';
import 'package:siscom_mobile/app/data/models/product_model.dart';
import 'package:siscom_mobile/app/data/repositories/category/category_repository.dart';
import 'package:siscom_mobile/app/data/repositories/product/product_repository.dart';

class ProductAddController extends GetxController {
  final RxList<Category> categories = <Category>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  RxString selectedGroupItem = ''.obs;
  RxInt selectedCategoryId = 0.obs;
  final RxList groupItems = [
    'Laptop','Smartphone','Aksesoris','Komponen'
  ].obs;
  final RxBool isLoadingCategories = true.obs;

  @override
  void onReady() {
    fetchCategories();
    super.onClose();
  }

  void fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final categoryRepository = Get.find<CategoryRepository>();
      final fetchedCategories = await categoryRepository.getCategories();
      if (fetchedCategories.isNotEmpty) {
        categories.assignAll(fetchedCategories);
      } else {
        categories.clear();
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to load categories: $error');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  void saveProduct() async {
    if (formKey.currentState!.validate()) {
      try {
        final productRepository = Get.find<ProductRepository>();
        final product = Product(
          name: nameController.text,
          price: int.parse(priceController.text.replaceAll(RegExp(r'[^0-9]'), '')),
          description: descriptionController.text,
          categoryId: selectedCategoryId.value,
          stock: int.parse(stockController.text),
          imageUrl: imageController.text,
          groupItem: selectedGroupItem.value,
        );
        await productRepository.createProduct(product);
        Get.snackbar('Success', 'Product added successfully', backgroundColor: Colors.green);
        Get.offAllNamed('/product');

      } catch (error) {
        Get.snackbar('Error', 'Failed to add product: $error');
      }
    }
  }
}
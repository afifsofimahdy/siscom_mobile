import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:siscom_mobile/app/data/models/category_model.dart';
import 'package:siscom_mobile/app/data/models/product_model.dart';
import 'package:siscom_mobile/app/data/repositories/category/category_repository.dart';
import 'package:siscom_mobile/app/data/repositories/product/product_repository.dart';

class ProductController extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasMoreData = true.obs;
  final RxList<Category> categories = <Category>[].obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final Rx<Category?> selectedCategory = Rx<Category?>(null);
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalItems = 0.obs;
  final RxInt pageSize = 10.obs;
  final RxList groupItems = [
    'Laptop','Smartphone','Aksesoris','Komponen'
  ].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      filterProducts();
      update();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (hasMoreData.value && !isLoading.value) {
          loadMoreProducts();
        }
      }
    });
  }

  @override 
  void onReady() {
    fetchCategories();
    fetchProducts(reset: true);
    super.onReady();
  }

  void filterProducts() {
    Logger().w(products.toSet());
    if (searchController.text.isEmpty) {
      filteredProducts.assignAll(products);
      return;
    }

    final query = searchController.text.toLowerCase();
    filteredProducts.assignAll(
      products.where((product) => 
        product.name.toLowerCase().contains(query) ||
        product.groupItem.toLowerCase().contains(query) ||
        product.category.name.toLowerCase().contains(query)
      ).toList()
    );
    update(); 
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
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
      isLoading.value = false;
    }
  }

  Future<void> fetchProducts({bool reset = false}) async {
    try {
      if (reset) {
        currentPage.value = 1;
        products.clear();
        hasMoreData.value = true;
      }
      isLoading.value = true;

      final productRepository = Get.find<ProductRepository>();
      final response = await productRepository.getAllProductsWithMeta(
        page: currentPage.value,
        limit: pageSize.value,
      );

      if (response.success) {
        final productData = response.data;
        final meta = productData.meta;
        
        totalItems.value = meta.total;
        totalPages.value = meta.totalPages;
        pageSize.value = meta.limit;

        if (productData.data.isNotEmpty) {
          products.addAll(productData.data);
          filteredProducts.assignAll(products);
          hasMoreData.value = currentPage.value < meta.totalPages;
          currentPage.value++;
        } else {
          if (currentPage.value == 1) {
            Get.snackbar('No Products', 'No products available at the moment.');
          }
          hasMoreData.value = false;
        }
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to load products: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void loadMoreProducts() {
    if (!isLoading.value && hasMoreData.value) {
      fetchProducts();
    }
  }

  void refreshProducts() {
    fetchProducts(reset: true);
  }

  Future<void> createProduct(Product product) async {
    try {
      isLoading.value = true;
      final productRepository = Get.find<ProductRepository>();
      await productRepository.createProduct(product);
      refreshProducts();
      Get.snackbar('Success', 'Product created successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to create product: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(int id, Product product) async {
    try {
      isLoading.value = true;
      final productRepository = Get.find<ProductRepository>();
      await productRepository.updateProduct(id.toString(), product);
      refreshProducts();
      Get.snackbar('Success', 'Product updated successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to update product: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      isLoading.value = true;
      final productRepository = Get.find<ProductRepository>();
      await productRepository.deleteProduct(id.toString());
      refreshProducts();
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete product: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getProductById(int id) async {
    try {
      isLoading.value = true;
      final productRepository = Get.find<ProductRepository>();
      final product = await productRepository.getProductById(id.toString());
      selectedProduct.value = product;
    } catch (error) {
      Get.snackbar('Error', 'Failed to get product details: $error');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:siscom_mobile/app/data/models/category_model.dart';
import 'package:siscom_mobile/app/data/models/product_model.dart';
import 'package:siscom_mobile/app/data/repositories/product/product_repository.dart';

class ProductController extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasMoreData = true.obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);
  final Rx<Category?> selectedCategory = Rx<Category?>(null);
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxInt totalItems = 0.obs;
  final RxInt pageSize = 10.obs;
  // Track selected products with their quantities
  final RxMap<int, int> selectedProducts = <int, int>{}.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      filterProducts();
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
    fetchProducts(reset: true);
    searchController.addListener(() {
      filterProducts();
    });
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
        product.category!.name.toLowerCase().contains(query)
      ).toList()
    );
    update(); 
  }

  // Enhanced methods for checkbox and quantity functionality
  void toggleProductSelection(int productId) {
    if (selectedProducts.containsKey(productId)) {
      selectedProducts.remove(productId);
    } else {
      selectedProducts[productId] = 1; // Default quantity when selected
    }
    update();
  }

  void updateProductQuantity(int productId, int quantity) {
    if (quantity > 0) {
      selectedProducts[productId] = quantity;
    } else {
      selectedProducts.remove(productId);
    }
    update();
  }

  bool isProductSelected(int productId) {
    return selectedProducts.containsKey(productId);
  }

  int getProductQuantity(int productId) {
    return selectedProducts[productId] ?? 0;
  }

  void clearSelectedProducts() {
    selectedProducts.clear();
    update();
  }

  Future<void> fetchProducts({bool reset = false}) async {
    try {
      if (reset) {
        currentPage.value = 1;
        products.clear();
        hasMoreData.value = true;
        // Clear selections on reset
        clearSelectedProducts();
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

  Future<void> deleteSelectedProducts() async {
    try {
      isLoading.value = true;
      final productRepository = Get.find<ProductRepository>();
      final productIds = selectedProducts.keys.map((id) => id).toList();

      final success = await productRepository.deleteBatchProducts(productIds);
      
      if (success) {
        fetchProducts(reset: true);
        clearSelectedProducts();
        Get.snackbar('Success', 'Selected products deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete some or all selected products');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to delete selected products: $error');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToProductAddView() {
    Get.toNamed(
      '/product/add',
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
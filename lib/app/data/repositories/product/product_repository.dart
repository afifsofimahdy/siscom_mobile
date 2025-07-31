// ignore_for_file: unrelated_type_equality_checks

import 'package:get/get.dart';
import 'package:siscom_mobile/app/data/providers/api_service.dart';
import 'package:siscom_mobile/app/data/models/product_model.dart';
import 'package:siscom_mobile/app/utils/constants/api_endpoint.dart';

class ProductRepository {
  final List<Product> _products = [];
  final _apiService = ApiService();

  Future<ProductResponse> getAllProductsWithMeta({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiService.get(ApiEndpoint.getProducts(page: page));
      if (response.statusCode == 200) {
        return ProductResponse.fromJson(response.data);
      } else {
        return ProductResponse(
          success: false,
          message: 'Failed to fetch products',
          data: ProductData(
            data: [],
            meta: Meta(
              total: 0,
              page: page,
              limit: limit,
              totalPages: 0,
            ),
          ),
          error: 'Invalid response status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      Get.log('Error fetching products with meta: $error', isError: true);
      return ProductResponse(
        success: false,
        message: 'Error fetching products',
        data: ProductData(
          data: [],
          meta: Meta(
            total: 0,
            page: page,
            limit: limit,
            totalPages: 0,
          ),
        ),
        error: error.toString(),
      );
    }
  }


  Future<List<Product>> getAllProducts(int page) async {
    try {
      final response = await _apiService.get(ApiEndpoint.getProducts(page: page));    
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['data'];
        _products.clear();
        _products.addAll(data.map((item) => Product.fromJson(item)).toList());
        return _products;
      } else {
        return [];
      }
    } catch (error) {
      Get.log('Error fetching products: $error', isError: true);
      return [];
    }
  }

  Future<Product?> getProductById(String id) async {
    try {
      final response = await _apiService.get(ApiEndpoint.getProductById(id));
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return Product.fromJson(data);
      }
      return null;
    } catch (error) {
      Get.log('Error fetching product detail: $error', isError: true);
      return null;
    }
  }

  Future<bool> createProduct(Product product) async {
    try {
      final response = await _apiService.post(
        ApiEndpoint.createProduct(),
        data: {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'stock': product.stock,
          'image_url': product.imageUrl,
          'categoryId': product.categoryId,
          'group_item': product.groupItem,
        },
      );
      if (response.statusCode == 201) {
        _products.add(product);
        return true;
      }
      return false;
    } catch (error) {
      Get.log('Error creating product: $error', isError: true);
      return false;
    }
  }

  Future<bool> updateProduct(String id, Product product) async {
    try {
      final response = await _apiService.put(
        ApiEndpoint.updateProduct(id),
        data: {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          // Add other product properties as needed
        },
      );
      if (response.statusCode == 200) {
        final index = _products.indexWhere((p) => p.id == id);
        if (index != -1) {
          _products[index] = product;
        }
        return true;
      }
      return false;
    } catch (error) {
      Get.log('Error updating product: $error', isError: true);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final response = await _apiService.delete(ApiEndpoint.deleteProduct(id));
      if (response.statusCode == 200) {
        _products.removeWhere((product) => product.id == id);
        return true;
      }
      return false;
    } catch (error) {
      Get.log('Error deleting product: $error', isError: true);
      return false;
    }
  }

  Future<bool> deleteBatchProducts(List<int> ids) async {
    try {
      final response = await _apiService.delete(
        ApiEndpoint.deleteBatchProducts(),
        data: {'ids': ids},
      );
      if (response.statusCode == 200) {
        _products.removeWhere((product) => ids.contains(product.id));
        return true;
      }
      return false;
    } catch (error) {
      Get.log('Error deleting batch products: $error', isError: true);
      return false;
    }
  }
}
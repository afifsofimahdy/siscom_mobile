// ignore_for_file: unused_import

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoint {
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  // Products
  static String getProducts({int page = 1}) => '$baseUrl/products?page=$page';
  static String getProductById(String id) => '$baseUrl/products/$id';
  static String createProduct() => '$baseUrl/products';
  static String updateProduct(String id) => '$baseUrl/products/$id';
  static String deleteProduct(String id) => '$baseUrl/products/$id';
  static String deleteBatchProducts() => '$baseUrl/products/batch';

  // Categories
  static String getCategories({int page = 1}) => '$baseUrl/categories?page=$page';
  static String getCategoryById(String id) => '$baseUrl/categories/$id';
  static String getProductsByCategory(String id, {int page = 1}) => '$baseUrl/categories/$id/products?page=$page';
  static String createCategory() => '$baseUrl/categories';
  static String updateCategory(String id) => '$baseUrl/categories/$id';
  static String deleteCategory(String id) => '$baseUrl/categories/$id';
}
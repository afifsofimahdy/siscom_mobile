import 'package:siscom_mobile/app/data/models/category_model.dart';
import 'package:siscom_mobile/app/data/providers/api_service.dart';
import 'package:siscom_mobile/app/utils/constants/api_endpoint.dart';

class CategoryRepository {
  Future<List<Category>> getCategories({int page = 1}) async {
    try {
      final response = await ApiService().get(
        ApiEndpoint.getCategories(page: page),
      );
      return (response.data['data']['data'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> getCategoryById(String id) async {
    try {
      final response = await ApiService().get(
        ApiEndpoint.getCategoryById(id),
      );
      return Category.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> createCategory(Category category) async {
    try {
      final response = await ApiService().post(
        ApiEndpoint.createCategory(),
        data: {
          'name': category.name,
          'description': category.description,
        },
      );
      return Category.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> updateCategory(String id, Category category) async {
    try {
      final response = await ApiService().put(
        ApiEndpoint.updateCategory(id),
        data: {
          'name': category.name,
          'description': category.description,
        },
      );
      return Category.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await ApiService().delete(
        ApiEndpoint.deleteCategory(id),
      );
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:siscom_mobile/app/data/models/category_model.dart';

class ProductResponse {
  final bool success;
  final String message;
  final ProductData data;
  final dynamic error;
  
  ProductResponse({
    required this.success,
    required this.message,
    required this.data,
    this.error,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      success: json['success'],
      message: json['message'],
      data: ProductData.fromJson(json['data']),
      error: json['error'],
    );
  }
}

class ProductData {
  final List<Product> data;
  final Meta meta;

  ProductData({
    required this.data,
    required this.meta,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      data: (json['data'] as List).map((item) => Product.fromJson(item)).toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}

class Product {
  final int? id;
  final String name;
  final String description;
  final int price;
  final int stock;
  final String imageUrl;
  final String groupItem;
  final int categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.groupItem,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      imageUrl: json['image_url'],
      groupItem: json['group_item'],
      categoryId: json['categoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      category: Category.fromJson(json['category']),
    );
  }
}
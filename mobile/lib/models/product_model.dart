import 'package:mobile/models/category_model.dart';
import 'package:mobile/models/gallery_model.dart';

class ProductModel{
  int id;
  String name;
  double price;
  String description;
  String? tags;
  CategoryModel? category;
  DateTime createdAt;
  DateTime updatedAt;
  List<GalleryModel> galleries;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.tags,
    this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.galleries
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(
      id: json['id'], 
      name: json['name'], 
      price: json['price'], 
      description: json['description'], 
      tags: json['tags']!, 
      category: CategoryModel.fromJson(json['category']!), 
      galleries: (json['galleries'] as List).map((e) => GalleryModel.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['created_at']), 
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category!.toJson(),
      'galleries': galleries.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
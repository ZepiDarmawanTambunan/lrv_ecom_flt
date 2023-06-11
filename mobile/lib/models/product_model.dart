import 'package:mobile/models/category_model.dart';
import 'package:mobile/models/gallery_model.dart';

class ProductModel{
  int id;
  String name;
  num price;
  String description;
  String? tags;
  CategoryModel? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<GalleryModel> galleries;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.tags,
    this.category,
    this.createdAt,
    this.updatedAt,
    required this.galleries
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){
    var data =  ProductModel(
      id: json['id'], 
      name: json['name'], 
      price: json['price'], 
      description: json['description'], 
      tags: json['tags'] ?? null, 
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null, 
      galleries: (json['galleries'] as List).map<GalleryModel>((e) => GalleryModel.fromJson(e)).toList(),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null, 
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
    print(data.toJson());
    return data;
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category != null ? category!.toJson() : null,
      'galleries': galleries.map((e) => e.toJson()).toList(),
      'created_at': createdAt != null ? createdAt!.toString() : null,
      'updated_at': updatedAt != null ? updatedAt!.toString() : null,
    };
  }
}
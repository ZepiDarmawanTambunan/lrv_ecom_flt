import 'package:mobile/models/gallery_model.dart';
import 'package:mobile/models/product_model.dart';

class MessageModel{
  String message;
  int userId;
  String userName;
  String userImage;
  bool isFromUser;
  ProductModel product;
  DateTime? createdAt;
  DateTime? updatedAt;

  MessageModel({required this.message,
  required this.userId,
  required this.userName,
  required this.userImage,
  required this.isFromUser,
  required this.product,
  this.createdAt,
  this.updatedAt
  });

  factory MessageModel.fromJson(Map<String, dynamic> json){
    var data =  MessageModel(
      message: json['message'],
      userId: json['userId'],
      userName: json['userName'],
      userImage: json['userImage'],
      isFromUser: json['isFromUser'],
      product: json['product'].isEmpty ? UninitializedProductModel(id: 999, name: '', price: 1, description: '', galleries: [GalleryModel(id: 1, url: '')]) : ProductModel.fromJson(json['product']),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(), 
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
    return data;
  }

    Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'isFromUser': isFromUser,
      'product': product is UninitializedProductModel ? {} : product.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
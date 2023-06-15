import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/models/user_model.dart';

class MessageService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addMessage({required UserModel user,
  required bool isFromUser, 
  required String message,
  required ProductModel product})
  async{
    try {
      firestore.collection('messages').add({
        'userId': user.id,
        'userName': user.name,
        'userImage': user.profilePhotoUrl,
        'isFromUser': true,
        'message': message,
        'product': product is UninitializedProductModel ? {} : product.toJson(),
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
      }).then((value) => print('Pesan berhasil dikirim'));
    } catch (e) {
      throw Exception('pesan gagal dikirim');
      print('$e');
    }
  }
}
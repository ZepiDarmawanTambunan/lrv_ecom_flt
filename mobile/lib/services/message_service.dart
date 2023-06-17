import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/models/message_model.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/models/user_model.dart';

class MessageService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({required int userId}){
    try {
      return firestore
      .collection('messages')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((QuerySnapshot list) {
        var result = list.docs.map((message){
          return MessageModel.fromJson(message.data() as Map<String, dynamic>);
        }).toList();
        result.sort((MessageModel a, MessageModel b) => a.createdAt!.compareTo(b.createdAt!));
        return result;
      });
    } catch (e) {
      throw Exception('terjadi kesalahan');
    }
  }

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
    }
  }
}
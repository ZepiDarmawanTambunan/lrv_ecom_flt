
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/services/product_service.dart';
import 'package:mobile/theme.dart';


class ImageProductProvider with ChangeNotifier{
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  int selectedFileCount = 0;

  Future<void> selectedMultipleImage(context)async{
    try {
      images = await _picker.pickMultiImage();
      if(images != null){
        for (XFile file in images!) {
          listImagePath.add(file.path);
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: alertColor,
          content: Text('Gagal! no item selected', textAlign: TextAlign.center,),),
        );
      }
      selectedFileCount = listImagePath.length;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void uploadImage({
    required String name, 
    required String description,
    required String tags,
    required String price,
    required int categoriesId,
    required List<String> listImagePath,
  }){
    if(selectedFileCount > 0){
      ProductService().createProduct(
        name: name, 
        description: description, 
        tags: tags, 
        price: price, 
        categoriesId: categoriesId, 
        listImagePath: listImagePath);
    }else{

    }
  }
}
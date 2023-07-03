
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/services/product_service.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';


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

  Future uploadImage({
    required BuildContext context,
    required String name, 
    required String description,
    required String tags,
    required String price,
    required int categoriesId,
    required List<String> listImagePath,
  })async{
    if(selectedFileCount > 0){
      try {
        ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
        ProductModel productModel = await ProductService().createProduct(
          name: name, 
          description: description, 
          tags: tags, 
          price: price, 
          categoriesId: categoriesId, 
          listImagePath: listImagePath
        );
        final oldProducts = productProvider.products;
        oldProducts.add(productModel);
        productProvider.products = oldProducts;
        print(productProvider.products);
        print(productModel.name);
        return productModel.name;
      } catch (e) {
       throw Exception(e); 
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: alertColor,
        content: Text("Wajib memilih images", textAlign: TextAlign.center,),),
      );
    }
  }

  void resetImageProvider(){
    images = [];
    listImagePath = [];
    selectedFileCount = 0;
    notifyListeners();
  }
}
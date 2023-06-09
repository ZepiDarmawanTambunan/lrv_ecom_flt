import 'dart:convert';
import 'package:mobile/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/providers/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductService{
  // String baseUrl = 'http://10.0.2.2:8000/api'; // localhost
  String baseUrl = 'http://192.168.1.7:8000/api'; // localhost ip wifi this laptop
  
  late SharedPreferences _prefs;

  Future<void> initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }


  Future<List<ProductModel>> getProducts ()async{
      var url = Uri.parse('$baseUrl/products');
      var headers = {'Content-type': 'application/json'};

      var response = await http.get(url, headers: headers);      

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data']['data'];
        List<ProductModel> products = [];
        for (var item in data) {
          products.add(ProductModel.fromJson(item));
        }
        return products;
      } else {
        throw Exception('Gagal mendapatkan data product');
      }
  }

  Future createProduct({
    required String name, 
    required String description, 
    required String tags,
    required String price,
    required int categoriesId,
    required List<String> listImagePath
    }) async{
    try {
      await initializePrefs(); 
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/products'));
      request.headers['Content-type'] = 'multipart/form-data';
      
      String token = _prefs.getString('token') ?? '';
      request.headers['Authorization'] = 'Bearer $token';

      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['tags'] = tags;
      request.fields['price'] = price;
      request.fields['categories_id'] = categoriesId.toString();

    for (int i = 0; i < listImagePath.length; i++) {
      var file = await http.MultipartFile.fromPath(
        'images[$i]',
        listImagePath[i],
        filename: "${DateTime.now().millisecondsSinceEpoch}.${listImagePath[i].split('.').last}",
      );
      request.files.add(file);
    }

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final responseData = jsonDecode(responseString)['data'];

      if (response.statusCode == 200) {
        final product = ProductModel.fromJson(responseData);
        return product;
      } else {
        throw Exception(responseData);
      }
    } catch (e) {
        throw Exception(e);
    }
  }
}
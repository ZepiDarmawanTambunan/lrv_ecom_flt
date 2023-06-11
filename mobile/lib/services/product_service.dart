import 'dart:convert';

import 'package:mobile/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService{
  String baseUrl = 'http://10.0.2.2:8000/api'; // localhost

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
        throw Exception('Gagal mendapatkan data pengguna');
      }
  }
}
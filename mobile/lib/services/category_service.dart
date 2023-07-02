import 'dart:convert';

import 'package:mobile/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryService{
  String baseUrl = 'http://10.0.2.2:8000/api'; // localhost
  // String baseUrl = 'http://192.168.114.97:8000/api'; // localhost ip wifi to hp

  Future<List<CategoryModel>> getCategories ()async{
      var url = Uri.parse('$baseUrl/categories');
      var headers = {'Content-type': 'application/json'};

      var response = await http.get(url, headers: headers);      

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body)['data']['data'];
        List<CategoryModel> categories = [];
        for (var item in data) {
          categories.add(CategoryModel.fromJson(item));
        }
        return categories;
      } else {
        throw Exception('Gagal mendapatkan data category');
      }
  }
}
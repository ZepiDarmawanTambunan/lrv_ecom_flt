import 'dart:convert';

import 'package:mobile/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService{
  // String baseUrl = 'http://10.0.2.2:8000/api'; // localhost
  String baseUrl = 'http://192.168.1.7:8000/api'; // localhost ip this wifi laptop

    Future<UserModel> register({
    required String name, 
    required String username, 
    required String email,
    required String password
    }) async{
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });
    
    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
  
    if(response.statusCode == 200){
      var data = jsonDecode(response.body)['data'];
      data['user']['token'] = 'Bearer '+data['access_token'];
      UserModel user = UserModel.fromJson(data['user']);
      return user;
    }else{
      throw Exception('Gagal Registrasi');
    }
  }

    Future<UserModel> login({ 
    required String email,
    required String password
    }) async{
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body)['data'];
      data['user']['token'] = 'Bearer '+data['access_token'];
      UserModel user = UserModel.fromJson(data['user']);
      return user;
    }else{
      throw Exception('Gagal Login');
    }
  }

    Future<UserModel> getUser(String token) async {
      var url = Uri.parse('$baseUrl/user');
      var headers = {'Content-type': 'application/json', 'Authorization': token};
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        data['token'] = token;
        UserModel user = UserModel.fromJson(data);
        return user;
      } else {
        throw Exception('Gagal mendapatkan data pengguna');
      }
    }

    Future<bool> logout(String token) async {
      var url = Uri.parse('$baseUrl/user');
      var headers = {'Content-type': 'application/json', 'Authorization': token};
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }

}
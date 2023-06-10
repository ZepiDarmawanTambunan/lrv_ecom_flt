import 'package:flutter/material.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier{
  late UserModel _user;
  late SharedPreferences _prefs;

  UserModel get user => _user;

  set user(UserModel user){
    _user = user;
    notifyListeners();
  }

    Future<bool> initializeAuthProvider() async {
      _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString('token') ?? '';
      if (token != '') {
        try {
          _user = await AuthService().getUser(token);
          return true;
        } catch (e) {
          return false;
        }
      }
      return false;
    }

    Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
    })async{
      try {
        UserModel user = await AuthService().register(
          name: name, 
          username: username, 
          email: email, 
          password: password);

          _user = user;
          _prefs.setString('token', user.token);
          return true;
      } catch (e) {
        return false;
      }
    }

    Future<bool> login({
    required String email,
    required String password,
    })async{
      try {
        UserModel user = await AuthService().login(
          email: email,
          password: password);
          _user = user;
           _prefs.setString('token', user.token);
          return true;
      } catch (e) {
        return false;
      }
    }

    Future<bool> logout()async{
      _prefs = await SharedPreferences.getInstance();
      String token = _prefs.getString('token') ?? '';
      await AuthService().logout(token);
      await _prefs.remove('token');
      return true;
    }
}
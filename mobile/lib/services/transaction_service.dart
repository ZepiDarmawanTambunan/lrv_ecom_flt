import 'dart:convert';
import 'package:mobile/models/cart_model.dart';
import 'package:http/http.dart' as http;

class TransactionService{
  // String baseUrl = 'http://10.0.2.2:8000/api'; // localhost
  String baseUrl = 'http://192.168.1.7:8000/api'; // localhost ip this laptop

  Future<bool> checkout (String token, List<CartModel> carts, num totalPrice)async{

      var url = Uri.parse('$baseUrl/checkout');
      var headers = {'Content-type': 'application/json',
      'Authorization': token,
      };

      var body = jsonEncode({
        'address': 'Jambi',
        'items': carts.map((cart) => {
          'id' : cart.product.id,
          'quantity': cart.quantity,
        }).toList(),
        'status': 'PENDING',
        'total_price': totalPrice,
        'shipping_price': 0,
      });

      var response = await http.post(url, headers: headers, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Gagal checkout');
      }
  }
}
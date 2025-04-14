import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/login_model.dart';

class AuthService {
  Future<LoginModel> login(String identifier, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
          Constant.loginEndpoint,
        ),
        body: {
          'identifier': identifier,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String,dynamic> data = json.decode(response.body);
        print('data : ${data}');
        print('token : ${json.decode(response.body)['data']['token']}');
        return LoginModel.fromJson(data);
      } else {
        print(response.statusCode);
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('$e');
    }
  }

  Future<Register> register(String fullName,String username,String email,String password,String phone) async{
    try {
      final response = await http.post(Uri.parse(Constant.registerEndpoint), body: {
        'full_name': fullName,
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
      });
      print("response body: ${response.body}");
      return Register.fromJson(json.decode(response.body));
    } catch (e) {
      print('Error: $e');
      throw Exception('$e');     
    }
  }
}

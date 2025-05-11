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
        final Map<String, dynamic> data = json.decode(response.body);
        return LoginModel.fromJson(data);
      } else {
        throw Exception('username or password is incorrect');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<Register> register(String fullName, String username, String email,
      String password, String phone) async {
    try {
      final response =
          await http.post(Uri.parse(Constant.registerEndpoint), body: {
        'full_name': fullName,
        'username': username,
        'email': email,
        'password': password,
        'phone': phone,
      });
      print("response : ${response.body}");
      return Register.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception('$e');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/auth/register/register_model.dart';

class RegisterService {
  Future<RegisterResponse> register(String fullName, String username,
      String email, String password, String phone) async {
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
      return RegisterResponse.fromJson(json.decode(response.body));
    } catch (e) {
      throw Exception('$e');
    }
  }
}

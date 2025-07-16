import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/auth/login/login_model.dart';

class LoginService {
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
}

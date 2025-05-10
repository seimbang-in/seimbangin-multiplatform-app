import 'dart:convert';
import 'dart:ffi';

import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/advice_model.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:seimbangin_app/utils/token.dart';

class UserService {
  Future<User> getUserProfile() async {
    try {
      final String? token = await Token.getToken();
      final response =
          await http.get(Uri.parse(Constant.getUserProfileEndpoint), headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print('response status code : ${response.statusCode}');
      print('response body : ${response.body}');
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } catch (e) {
      print('Error: $e');
      throw Exception('$e');
    }
  }

  Future<Advice> getUserAdvice() async {
    try {
      final String? token = await Token.getToken();
      final response =
          await http.get(Uri.parse(Constant.getUserAdviceEndpoint), headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      final Map<String, dynamic> data = json.decode(response.body);
      return Advice.fromJson(data);
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> updateUserProfile(int currentSavings, int debt,
      String financialGoals, String riskManagement) async {
    try {
      final String? token = await Token.getToken();
      final response = await http.put(
        Uri.parse(Constant.updateUserProfileEndpoint),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'current_savings': currentSavings,
          'debt': debt,
          'financial_goals': financialGoals,
          'risk_management': riskManagement,
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
      print('response status code : ${response.statusCode}');
      print('response body : ${response.body}');
    } catch (e) {
      throw Exception('$e');
    }
  }
}

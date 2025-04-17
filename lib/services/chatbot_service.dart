import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/utils/token.dart';

class ChatbotService {
  Future<String> getChatbotResponse(String message) async {
    try {
      final String? token = await Token.getToken();
      final response = await http.post(
        Uri.parse(Constant.chatbotReplyEndpoint),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data']['reply'];
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

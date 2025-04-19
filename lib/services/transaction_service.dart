import 'dart:convert';

import 'package:seimbangin_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:seimbangin_app/ui/pages/transactions_page.dart';
import 'package:seimbangin_app/utils/token.dart';

class TransactionService {
  Future<void> addTransaction(
      List<Item> items, int type, String description) async {
    try {
      final String? token = await Token.getToken();
      final response =
          await http.post(Uri.parse(Constant.addTransactionEndpoint),
              headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                'type': type,
                'description': description,
                'items': items.map((item) => item.toJson()).toList(),
              }));
      print('response status code : ${response.statusCode}');
      print('response body : ${response.body}');
    } catch (e) {
      print('Error : $e');
      throw Exception('Error: $e');
    }
  }
}

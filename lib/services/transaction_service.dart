import 'dart:convert';
import 'package:seimbangin_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_model.dart';
import 'package:seimbangin_app/utils/token.dart';

class TransactionService {
  Future<void> addTransaction(
      List<Item> items, int type, String description, String name) async {
    // ... (tidak ada perubahan di sini)
  }

  // --- PERUBAHAN DI SINI ---
  // Tambahkan parameter 'page'
  Future<Transaction> getTransaction(
      {required int limit, required int page}) async {
    try {
      final String? token = await Token.getToken();
      // Tambahkan parameter 'page' ke URL endpoint
      final url = '${Constant.getTransactionEndpoint}?limit=$limit&page=$page';

      final response = await http.get(Uri.parse(url), headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print('Requesting URL: $url');
      print('response status code : ${response.statusCode}');
      print('response body : ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Transaction.fromJson(data);
      } else {
        throw Exception('Failed to load transaction: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load transaction: $e');
    }
  }
}

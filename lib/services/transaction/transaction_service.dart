import 'dart:convert';
import 'package:seimbangin_app/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/utils/token.dart';

class TransactionService {
  Future<void> addTransaction(List<TransactionItem> items, int type,
      String description, String name) async {
    final String? token = await Token.getToken();
    if (token == null) {
      print('[TransactionService] ADD TRANSACTION - Error: Token is null.');
      throw Exception('Error: Authentication token is missing.');
    }

    final Map<String, dynamic> payloadMap = {
      'type': type,
      'description': description,
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
    final String jsonPayload = jsonEncode(payloadMap);

    print('---------------------------------------------------');
    print('[TransactionService] Attempting to Add Transaction');
    print('[TransactionService] Endpoint: ${Constant.addTransactionEndpoint}');
    print('[TransactionService] ADD TRANSACTION PAYLOAD: $jsonPayload');
    print('---------------------------------------------------');

    try {
      final response = await http.post(
        Uri.parse(Constant.addTransactionEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonPayload,
      );

      print(
          '[TransactionService] ADD TRANSACTION - Response Status Code: ${response.statusCode}');
      print(
          '[TransactionService] ADD TRANSACTION - Response Body: ${response.body}');
      print('---------------------------------------------------');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
            'Failed to add transaction. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print(
          '[TransactionService] ADD TRANSACTION - Error during HTTP call: $e');
      print('---------------------------------------------------');
      throw Exception('Error during addTransaction HTTP call: $e');
    }
  }

  Future<TransactionResponse> getTransaction(
      {required int limit, required int page}) async {
    final String? token = await Token.getToken();
    if (token == null) {
      print('[TransactionService] GET TRANSACTION - Error: Token is null.');
      throw Exception(
          'Error: Authentication token is missing for getTransaction.');
    }
    final url = '${Constant.getTransactionEndpoint}?limit=$limit&page=$page';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return TransactionResponse.fromJson(data);
      } else {
        throw Exception(
            'Failed to load transaction (GET): ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to load transaction (GET): $e');
    }
  }
}

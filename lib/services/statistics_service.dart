import 'dart:convert';

import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/statistics_model.dart';
import 'package:http/http.dart' as http;
import 'package:seimbangin_app/utils/token.dart';

class StatisticsService {
  Future<StatisticsModel> getMonthlyStatistics() async {
    try {
      final String? token = await Token.getToken();
      final response = await http
          .get(Uri.parse(Constant.statisticsMonthlyEndpoint), headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token',
      });
      print('response status code : ${response.statusCode}');
      print('response body : ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return StatisticsModel.fromJson(data);
      } else {
        throw Exception('Failed to load statistics: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load statistics: $e');
    }
  }
}

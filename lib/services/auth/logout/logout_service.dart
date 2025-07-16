import 'package:http/http.dart' as http;
import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/utils/token.dart';

class LogoutService {
  Future<void> logout() async {
    final String? token = await Token.getToken();

    if (token == null) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(Constant.logoutEndpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Gagal logout dari server: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan jaringan saat logout.');
    }
  }
}

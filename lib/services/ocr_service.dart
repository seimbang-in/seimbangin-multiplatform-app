import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/ocr_item_models.dart';

class OcrService {
  Future<OcrItem> getOcrItem(File imageFile) async {
    try {
      var uri = Uri.parse(Constant.ocrEndpooint);
      var request = http.MultipartRequest('POST', uri)
        ..files.add(
          await http.MultipartFile.fromPath('photo', imageFile.path,
              filename: basename(imageFile.path)),
        );

      var ocrResponse = await request.send();
      var response = await http.Response.fromStream(ocrResponse);
      final Map<String, dynamic> data = json.decode(response.body);
      return OcrItem.fromJson(data);
    } catch (e) {
      throw Exception("Error uploading image: $e");
    }
  }
}

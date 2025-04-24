import 'dart:convert';
import 'dart:io';

import 'package:seimbangin_app/config/constants.dart';
import 'package:seimbangin_app/models/ocr_model.dart';
import 'package:http/http.dart' as http;
import 'package:seimbangin_app/utils/token.dart';
import 'package:image/image.dart' as img;
import 'package:http_parser/http_parser.dart';

class OcrService {
  Future<OcrModel> extractOcrData(String imagePath) async {
    try {
      final String? token = await Token.getToken();
      final uri = Uri.parse(Constant.ocrEndpoint);
      final convertedPath = await convertToJpeg(imagePath);

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('photo', convertedPath,
            contentType: MediaType('image', 'jpeg')));

      final file = File(imagePath);
      print("File exists: ${file.existsSync()}");
      print("File path: $imagePath");
      print("File length: ${await file.length()} bytes");

      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("Response body: ${response.body}");
        print("Response status code: ${response.statusCode}");
        final OcrModel ocrModel = OcrModel.fromJson(jsonData);
        return ocrModel;
      } else {
        print("Response body: ${response.body}");
        print("Response status code: ${response.statusCode}");
        throw Exception('Failed to extract OCR data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to extract OCR data: $e');
    }
  }

  Future<String> convertToJpeg(String originalPath) async {
    final imageFile = File(originalPath);
    final bytes = await imageFile.readAsBytes();
    final decodedImage = img.decodeImage(bytes);

    if (decodedImage == null) throw Exception('Could not decode image');

    final jpg = img.encodeJpg(decodedImage);
    final newPath = '${originalPath}_converted.jpg';
    final convertedFile = await File(newPath).writeAsBytes(jpg);
    return convertedFile.path;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class ApiService {
  static const Duration _timeout = Duration(seconds: 30);

  static Future<String?> processImage(
    File imageFile,
    String endpoint, {
    Map<String, double>? params,
  }) async {
    try {
      final uri = Uri.parse('${AppConstants.apiUrl}/$endpoint');
      final request = http.MultipartRequest('POST', uri);

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      if (params != null) {
        params.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      final streamedResponse = await request.send().timeout(_timeout);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['image'];
      }
      return null;
    } catch (e) {
      print('API Error: $e');
      return null;
    }
  }

  static Future<bool> checkHealth() async {
    try {
      final response = await http
          .get(Uri.parse('${AppConstants.apiUrl}/health'))
          .timeout(_timeout);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.vyro.ai/v2/image/generations';

  String apiKey = dotenv.env['API_KEY']!;

  Future<List<int>> generateImage(String prompt) async {
    try {
      var headers = {
        'Authorization':
            'Bearer $apiKey' // Use the constant instead of hardcoding
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse(baseUrl)); // Use the constant instead of hardcoding
      request.fields.addAll({
        'prompt': prompt, // Use the parameter instead of hardcoded value
        'style': 'realistic',
        'aspect_ratio': '1:1',
        'seed': '5'
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Return the bytes directly instead of converting to string
        final bytes = await response.stream.toBytes();
        return bytes;
      } else {
        log('Error: ${response.statusCode} ${response.reasonPhrase}');
        throw Exception('Failed to generate image: ${response.statusCode}');
      }
    } catch (e) {
      log('Error generating image: $e');
      throw Exception('Error generating image: $e');
    }
  }
}

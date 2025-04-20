import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:remagine/services/api_service.dart';

class ImageGeneratorProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  Uint8List? _generatedImageBytes;
  bool _isLoading = false;
  String? _error;

  Uint8List? get generatedImageBytes => _generatedImageBytes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> generateImage(String prompt) async {
    if (prompt.isEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final imageBytes = await _apiService.generateImage(prompt);
      _generatedImageBytes = Uint8List.fromList(imageBytes);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _generatedImageBytes = null;
    _error = null;
    notifyListeners();
  }
}
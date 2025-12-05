import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../config/constants.dart';
import '../services/api_service.dart';

class ImageProcessingProvider extends ChangeNotifier {
  File? _originalImage;
  Uint8List? _processedImage;
  bool _isLoading = false;
  String? _error;
  String? _successMessage;
  OperationCategory? _selectedCategory;
  Operation? _selectedOperation;
  Map<String, double> _params = {};

  File? get originalImage => _originalImage;
  Uint8List? get processedImage => _processedImage;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get successMessage => _successMessage;
  OperationCategory? get selectedCategory => _selectedCategory;
  Operation? get selectedOperation => _selectedOperation;
  Map<String, double> get params => _params;

  final ImagePicker _picker = ImagePicker();

  void clearMessages() {
    _error = null;
    _successMessage = null;
  }

  Future<void> pickImage(ImageSource source) async {
    clearMessages();
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        _originalImage = File(image.path);
        _processedImage = null;
        notifyListeners();
      }
    } catch (e) {
      _error = 'Cannot select image';
      notifyListeners();
    }
  }

  void selectCategory(OperationCategory category) {
    clearMessages();
    _selectedCategory = category;
    _selectedOperation = null;
    _params = {};
    notifyListeners();
  }

  void selectOperation(Operation operation) {
    clearMessages();
    _selectedOperation = operation;
    _params = {};
    if (operation.params != null) {
      for (var param in operation.params!) {
        _params[param.name] = param.defaultValue;
      }
    }
    notifyListeners();
  }

  void updateParam(String name, double value) {
    _params[name] = value;
    notifyListeners();
  }

  Future<void> processImage() async {
    if (_originalImage == null || _selectedOperation == null) return;

    _isLoading = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      final result = await ApiService.processImage(
        _originalImage!,
        _selectedOperation!.id,
        params: _params.isNotEmpty ? _params : null,
      );

      if (result != null) {
        _processedImage = base64Decode(result);
        _successMessage = 'Processing completed!';
      } else {
        _error = 'Processing failed';
      }
    } catch (e) {
      _error = 'Server connection error';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String?> saveProcessedImage() async {
    if (_processedImage == null) return null;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/processed_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(path);
      await file.writeAsBytes(_processedImage!);
      _successMessage = 'Image saved!';
      notifyListeners();
      return path;
    } catch (e) {
      _error = 'Cannot save image';
      notifyListeners();
      return null;
    }
  }

  void reset() {
    _originalImage = null;
    _processedImage = null;
    _selectedCategory = null;
    _selectedOperation = null;
    _params = {};
    _error = null;
    _successMessage = null;
    notifyListeners();
  }
}

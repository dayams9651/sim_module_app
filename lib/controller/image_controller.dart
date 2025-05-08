import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UploadController extends GetxController {
  final box = GetStorage();
  final isLoading = false.obs;

  Future<void> uploadSimData({
    required String simNo,
    required String serial,
    required File? imageFile,
    required TextEditingController simController,
    required TextEditingController serialController,
    required String simType,
  }) async {
    isLoading(true);

    try {
      String? token = box.read('token');
      if (token == null || token.isEmpty) {
        Get.snackbar(
          'Error',
          'Token not found. Please log in again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
        return;
      }

      if (imageFile == null) {
        Get.snackbar("Error", "Please capture an image first",
            backgroundColor: Colors.red);
        return;
      }

      final url = Uri.parse("https://api-bpe.mscapi.live/swipeMachine/upload");
      var request = http.MultipartRequest('POST', url);
      request.fields['sim_no'] = simNo;
      request.fields['serial'] = serial;
      request.fields['sim_type'] = simType;
      request.headers['Authorization'] = '$token';

      var imageBytes = await imageFile.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final responseData = jsonDecode(responseBody);
        String message = responseData['message'] ?? 'Data uploaded successfully';
        Get.snackbar("Success", message, backgroundColor: Colors.green);
        simController.clear();
        serialController.clear();
        imageFile = null;
      } else {
        final responseData = jsonDecode(responseBody);
        String message = responseData['message'] ?? 'Upload failed';
        Get.snackbar("Failed", message, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar(
          "Error", "Something went wrong: $e", backgroundColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }
}


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile_code/style/color.dart';
import '../const/api_url.dart';

class UploadController extends GetxController {
  final selectedImages = <File>[].obs;
  final box = GetStorage();
  final isLoading = false.obs;

  void pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        selectedImages.add(File(pickedFile.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: ${e.toString()}');
    }
  }

  // Future<String?> pickImageFromCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     final compressedData = await FlutterImageCompress.compressWithFile(
  //       image.path,
  //       quality: 80,
  //     );
  //     if (compressedData != null) {
  //       final compressedFile = File(image.path)..writeAsBytesSync(compressedData);
  //       final fileSizeInBytes = compressedFile.lengthSync();
  //       debugPrint("Captured image size: ${fileSizeInBytes / 1024} KB");
  //       if (fileSizeInBytes <= 819200) {
  //         selectedImages.add(compressedFile,);
  //         return compressedFile.path;
  //       } else {
  //         debugPrint("Image is too large. Max allowed size is 800KB.");
  //       }
  //     }
  //   }
  //   return null;
  // }

  void removeImage(File file) {
    selectedImages.remove(file);
  }

  Future<void> uploadSimData({
    required String simNo,
    required String serial,
  }) async {
    isLoading(true);

    try {
      String? token = box.read('token');
      debugPrint('Retrieved Token: $token');

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

      if (selectedImages.isEmpty) {
        Get.snackbar("Error", "Please select an image first");
        return;
      }

      // final url = Uri.parse("https://api-bpe.mscapi.live/swipeMachine/ecom/upload");
      final url = Uri.parse(uploadSimDetailsApi);

      var request = http.MultipartRequest('POST', url);
      request.fields['sim_no'] = simNo;
      request.fields['serial'] = serial;

      var imageFile = selectedImages.first;
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      request.headers['Authorization'] = '$token';

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        debugPrint("Upload successful: $responseBody");
        Get.snackbar("Success", "Data uploaded successfully", backgroundColor: AppColors.success40);
        selectedImages.clear();
      } else {
        debugPrint("Upload failed: $responseBody");
        Get.snackbar(
          "Failed",
          "No Record found",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Upload exception: $e");
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
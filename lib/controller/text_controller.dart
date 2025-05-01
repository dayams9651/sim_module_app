import 'package:get/get.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextController extends GetxController {
  var detectedText = ''.obs;

  Future<void> detectTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    List<String> lines = recognizedText.text.split('\n');
    String processedText = lines.length > 1 ? lines.sublist(1).join('\n') : '';
    detectedText.value = processedText.length > 21 ? processedText.substring(0, 21) : processedText;
    await textRecognizer.close();
  }
}
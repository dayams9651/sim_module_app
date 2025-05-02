import 'package:get/get.dart';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextController extends GetxController {
  var detectedText = ''.obs;

  Future<void> detectTextFromImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String allText = recognizedText.text.replaceAll('\n', '');

    final RegExp pattern = RegExp(r'899.*?U');

    final match = pattern.firstMatch(allText);

    if (match != null) {
      String matchedText = match.group(0)!;
      detectedText.value = matchedText.length > 21 ? matchedText.substring(0, 21) : matchedText;
    } else {
      detectedText.value = '';
    }
    await textRecognizer.close();
  }
}

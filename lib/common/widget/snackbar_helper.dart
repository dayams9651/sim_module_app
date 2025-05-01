import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showCustomSnackbar(
    String title,
    String message, {
      SnackPosition position = SnackPosition.TOP,
      Color backgroundColor = Colors.white70, // Default background color
    })
{
  Get.snackbar(
    title,
    message,
    snackPosition: position,
    backgroundColor: backgroundColor, // Apply the background color
  );
}

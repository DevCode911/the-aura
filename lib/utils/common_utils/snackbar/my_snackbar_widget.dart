import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBarWidget {
  static void showSnackbar( {
    required String title,
    required String message,

    SnackPosition? position,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: duration,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      icon: icon != null ? Icon(icon) : null,
    );
  }
}

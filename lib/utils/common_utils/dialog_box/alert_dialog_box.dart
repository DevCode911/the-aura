import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class AlertDialogBox {
  static void showAlertBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          "No Service Selected",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Text(
          "Please add at least one service before proceeding.",
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Closes the dialog
            child: Text(
              "OK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.lightPrimary,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible:
          false, // Optional: Prevent dialog from closing when tapping outside
    );
  }
}

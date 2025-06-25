import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/image_picker_controller.dart';
import '../../../res/app_theme/app_colors.dart';

class ProfileCircleAvtarWidget extends StatelessWidget {
  ProfileCircleAvtarWidget({super.key});

  final ImagePickerController imagePickerController =
      Get.find<ImagePickerController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final File? imageFile = imagePickerController.selectedImage.value;

      return Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                imageFile != null
                    ? FileImage(imageFile)
                    : NetworkImage(
                      "https://i.pinimg.com/736x/b7/51/99/b75199056b5dd384275a7728f0fc289c.jpg",
                    ),
          ),

          // Edit button
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => imagePickerController.pickImage(),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

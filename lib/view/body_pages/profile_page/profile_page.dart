import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/edit_profile_controller.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/res/routes/routes_name.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_icon_button_widget.dart';

import '../../../controller/image_picker_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final imagePickerController = Get.find<ImagePickerController>();
    final editProfileController = Get.find<EditProfileController>();


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> profileItem = [
      {"title": "Manage Address", "icon": Icons.location_on_outlined},
      {"title": "Refer and Earn", "icon": Icons.share_outlined},
      {"title": "Rate Us", "icon": Icons.star_outline},
      {"title": "About Us", "icon": Icons.info_outline},
      {"title": "About Services", "icon": Icons.help_outline},
      {"title": "Logout", "icon": Icons.logout},
    ];

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MyAppBarWidget(appBarName: "Profile", showBackButton: false),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Column(
            children: [
              profileDetails(
                context,
              ), // here profile Image and, number and Edit button
              const SizedBox(height: 20),
              const Divider(color: AppColors.grey),
              const SizedBox(height: 20),

              // here profile menu items
              Expanded(
                child: ListView.builder(
                  itemCount: profileItem.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItem(
                      context,
                      title: profileItem[index]["title"].toString(),
                      iconData: profileItem[index]["icon"],
                      onPressed: () {
                        switch (profileItem[index]["title"]) {
                          case "Manage Address":
                            Get.toNamed(RoutesName.manageAdressPage);
                            break;
                          case "Refer and Earn":
                            Get.toNamed(RoutesName.raferEarnPage);
                            break;
                          case "Rate Us":
                            Get.toNamed(RoutesName.rateUsPage);
                            break;
                          case "About Us":
                            Get.toNamed(RoutesName.aboutUsPage);
                            break;
                          case "About Services":
                            Get.toNamed(RoutesName.aboutServicesPage);
                            break;
                          case "Logout":
                            _showLogoutConfirmationDialog(context);
                            break;
                        }
                      },

                      isLogout: profileItem[index]["title"] == "Logout",
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // widgets

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData iconData,
    required VoidCallback onPressed,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData),
              const SizedBox(width: 15),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: onPressed,
                child: Text(title, style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
          MyIconButtonWidget(
            onPressed: onPressed,
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}

Widget profileDetails(BuildContext context) {
  final imagePickerController = Get.find<ImagePickerController>();

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    height: 100,
    child: Row(
      children: [
        Obx(() {
          final imageFile = imagePickerController.selectedImage.value;
          return CircleAvatar(
            backgroundColor: AppColors.grey.withAlpha(50),
            radius: 40,
            backgroundImage:
                imageFile != null
                    ? FileImage(imageFile) as ImageProvider
                    : NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL ??
                          "https://i.pinimg.com/736x/b7/51/99/b75199056b5dd384275a7728f0fc289c.jpg",
                    ),
          );
        }),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                FirebaseAuth.instance.currentUser!.displayName ?? "User",
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                '7016394629',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.lightPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: MyIconButtonWidget(
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.lightBackground,
            ),
            onPressed: () => Get.toNamed(RoutesName.editProfilePage),
          ),
        ),
      ],
    ),
  );
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: AppColors.lightPrimary),
            ),
          ),
          SizedBox(
            height: 40,
            width: 83,
            child: MyElevatedButtonWidget(
              buttonStyle: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.error,
              ),
              buttonName: "LOGOUT",
              onPressed: () {
                Get.offAllNamed(RoutesName.loginPage);
              },
            ),
          ),
        ],
      );
    },
  );
}

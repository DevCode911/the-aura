import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/edit_profile_controller.dart';
import 'package:the_aura/controller/image_picker_controller.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/circle_image/profile_circle_avtar_widget.dart';
import 'package:the_aura/utils/common_utils/textfield/my_textfield_widget.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final imagePickerController = Get.find<ImagePickerController>();
  final editProfileController = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(
      text: editProfileController.name.value,
    );
    final TextEditingController emailController = TextEditingController(
      text: editProfileController.email.value,
    );
    final TextEditingController phoneController = TextEditingController(
      text: editProfileController.phone.value,
    );

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: MyAppBarWidget(appBarName: "Edit Profile"),

        // Scrollable form body
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 70,
            bottom: 100,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Center(child: ProfileCircleAvtarWidget()),
                const SizedBox(height: 90),

                // Full Name
                MyTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    LengthLimitingTextInputFormatter(26),
                  ],
                  controller: nameController,
                  hintText: "Enter Full Name",
                  label: "Full Name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Email
                MyTextfieldWidget(
                  controller: emailController,
                  hintText: "Enter Email",
                  label: "E-mail",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }

                    final email = value.trim();

                    // More strict Gmail regex
                    final emailRegex = RegExp(
                      r'^[a-zA-Z][a-zA-Z0-9]{0,62}[a-zA-Z0-9]@gmail\.com$',
                    );

                    if (!emailRegex.hasMatch(email)) {
                      return 'Enter a valid Gmail address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Mobile Number
                MyTextfieldWidget(
                  controller: phoneController,
                  hintText: "Enter Mobile Number",
                  label: "Mobile Number",
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mobile Number is required';
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Enter a valid 10-digit number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),

        // Fixed Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: MyElevatedButtonWidget(
              buttonStyle: ElevatedButton.styleFrom(
                elevation: 0,
                textStyle: Theme.of(context).textTheme.headlineSmall,
              ),
              buttonName: "Save Changes",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  editProfileController.updateProfile(
                    newName: nameController.text.trim(),
                    newEmail: emailController.text.trim(),
                    newPhone: phoneController.text.trim(),
                  );
                  Get.back();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_text_button_widget.dart';
import 'package:the_aura/utils/common_utils/textfield/login_textfield_widget.dart';

import '../../res/routes/routes_name.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  titleSignUp(context),
                  const SizedBox(height: 50),
                  yourNameField(context),
                  emailField(context),
                  passwordField(context),
                  reEnterPasswordField(context),
                  const SizedBox(height: 30),
                  signUpButton(context),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      MyTextButtonWidget(
                        onPressed: () {
                          Get.offAllNamed(RoutesName.loginPage);
                        },
                        buttonName: "Login",
                        textStyle: TextStyle(color: AppColors.lightPrimary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------- UI widgets ---------- //

Widget titleSignUp(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "Sign Up",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: 50,
          color: AppColors.lightPrimary,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
      ),
      const SizedBox(height: 5),
      Container(width: 130, height: 2, color: AppColors.lightPrimary),
    ],
  );
}

Widget customField({
  required BuildContext context,
  required String headingTextfield,
  String? hintText,
  required TextEditingController controller,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(headingTextfield, style: const TextStyle(fontSize: 17)),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LoginTextFieldWidget(
          controller: controller,
          hintText: hintText,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    ],
  );
}

// ---------- Form Fields ---------- //

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

Widget yourNameField(BuildContext context) {
  return customField(
    context: context,
    headingTextfield: "Your Name",
    hintText: "Enter your name",
    controller: nameController,
    validator:
        (value) => value == null || value.isEmpty ? "Name is required" : null,
  );
}

Widget emailField(BuildContext context) {
  return customField(
    context: context,
    headingTextfield: "E-mail",
    hintText: "example@gmail.com",
    controller: emailController,
    validator: emailValidator,
  );
}

Widget passwordField(BuildContext context) {
  return customField(
    context: context,
    headingTextfield: "Password",
    hintText: "Create password",
    controller: passwordController,
    validator: passwordValidator,
  );
}

Widget reEnterPasswordField(BuildContext context) {
  return customField(
    context: context,
    headingTextfield: "Re-Enter Password",
    hintText: "Re-enter password",
    controller: confirmPasswordController,
    validator: (value) {
      if (value == null || value.isEmpty) return 'Please confirm password';
      if (value != passwordController.text) return 'Passwords do not match';
      return null;
    },
  );
}

// ---------- Buttons ---------- //

Widget signUpButton(BuildContext context) {
  return MyElevatedButtonWidget(
    buttonName: "SIGN UP",
    onPressed: () {
      // You can add form validation here
      Get.offAllNamed(RoutesName.bodyPage);
    },
    buttonStyle: ElevatedButton.styleFrom(
      foregroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.lightTextcolor
              : AppColors.lightTextcolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.grey.withAlpha(80)
                  : AppColors.lightPrimary,
        ),
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.grey.withAlpha(50)
              : AppColors.lightPrimary,
    ),
  );
}

// ---------- Validators ---------- //

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$");
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid Gmail address (e.g., example@gmail.com)';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Password must be at least 8 characters';
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  );
  if (!passwordRegex.hasMatch(value)) {
    return 'Include upper, lower, number & special char';
  }
  return null;
}

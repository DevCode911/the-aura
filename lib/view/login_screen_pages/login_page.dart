import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_aura/constant/asset_path.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_text_button_widget.dart';
import 'package:the_aura/utils/common_utils/textfield/login_textfield_widget.dart';
import 'package:the_aura/view_models/auth/auth_service.dart';
import '../../res/routes/routes_name.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  bool isLogin = true;

  // Login Controllers
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  // SignUp Controllers
  final nameController = TextEditingController();
  final emailSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    nameController.dispose();
    emailSignUpController.dispose();
    passwordSignUpController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    isLogin ? "Login" : "Sign Up",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 120,
                    height: 2,
                    color: AppColors.lightPrimary.withOpacity(0.6),
                  ),

                  const SizedBox(height: 40),

                  if (!isLogin)
                    customField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                        LengthLimitingTextInputFormatter(26),
                      ],
                      context: context,
                      headingTextfield: "Your Name",
                      controller: nameController,
                      hintText: "Enter your name",
                      validator:
                          (v) =>
                              v == null || v.isEmpty ? "Name required" : null,
                    ),

                  customField(
                    context: context,
                    headingTextfield: "Email",
                    controller:
                        isLogin ? emailLoginController : emailSignUpController,
                    hintText: "example@gmail.com",
                    validator: emailValidator,
                    inputFormatters: [
                      LowerCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(64),
                    ],
                  ),

                  customField(
                    context: context,
                    headingTextfield: "Password",
                    controller:
                        isLogin
                            ? passwordLoginController
                            : passwordSignUpController,
                    hintText: isLogin ? "Password" : "Create password",
                    validator: passwordValidator,
                  ),

                  if (!isLogin)
                    customField(
                      context: context,
                      headingTextfield: "Confirm Password",
                      controller: confirmPasswordController,
                      hintText: "Re-enter password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm password';
                        }
                        if (value != passwordSignUpController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                  // for got password
                  if (isLogin) forgotPassword(),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 45,
                    child: MyElevatedButtonWidget(
                      buttonName: isLogin ? "LOGIN" : "SIGN UP",
                      onPressed: () {
                        Get.offAllNamed(RoutesName.bodyPage);
                      },
                      buttonStyle: ElevatedButton.styleFrom(
                        elevation: 0,
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
                    ),
                  ),

                  const SizedBox(height: 30),
                  if (isLogin) orDivider(),
                  if (isLogin) const SizedBox(height: 30),

                  if (isLogin)
                    SizedBox(
                      height: 45,
                      child: MyElevatedButtonWidget(
                        buttonName: "Continue with Google",
                        isIcon: true,
                        image: AssetPath.googleLogo,
                        onPressed: () async {
                          try {
                            final userCredential =
                                await AuthService().signInWithGoogle();
                            final user = userCredential.user;
                            if (userCredential != null) {
                              Get.offAllNamed(RoutesName.bodyPage);
                              print("UID: ${user.uid}");
                              print("Name: ${user.displayName}");
                              print("Email: ${user.email}");
                              print("Photo URL: ${user.photoURL}");
                            }
                          } catch (e) {
                            Get.snackbar("Login", "Login failed. Try again.");
                          }
                        },

                        buttonStyle: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.lightTextcolor
                                  : AppColors.lightTextcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.grey.withAlpha(80)
                                      : AppColors.lightPrimary,
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.grey.withAlpha(50)
                                  : AppColors.lightPrimary,
                        ),
                      ),
                    ),

                  if (isLogin) const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isLogin
                            ? "Don't have an account?"
                            : "Already have an account?",
                        style: TextStyle(fontSize: 12),
                      ),
                      MyTextButtonWidget(
                        buttonName: isLogin ? "Sign up" : "Login",
                        textStyle: TextStyle(
                          color: AppColors.lightPrimary,
                          fontSize: 12,
                        ),
                        onPressed: () {
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print("Forgot password tapped"),
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: AppColors.lightPrimary, fontSize: 12),
        ),
      ),
    );
  }
}

// Common custom text field
Widget customField({
  required BuildContext context,
  required String headingTextfield,
  required TextEditingController controller,
  String? hintText,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(headingTextfield, style: const TextStyle(fontSize: 14)),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: LoginTextFieldWidget(
          controller: controller,
          hintText: hintText,
          validator: validator,
          inputFormatters: inputFormatters, // ✅ added
        ),
      ),
    ],
  );
}

Widget orDivider() {
  return Row(
    children: [
      Expanded(child: Divider(thickness: 1, color: Colors.grey)),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text("or", style: TextStyle(color: Colors.grey)),
      ),
      Expanded(child: Divider(thickness: 1, color: Colors.grey)),
    ],
  );
}

// Validators
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z][a-zA-Z0-9]{0,62}[a-zA-Z0-9]@gmail\.com$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid Gmail address';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Min 8 characters';
  final RegExp pattern = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
  );
  if (!pattern.hasMatch(value)) {
    return 'Include upper, lower, number & special char';
  }
  return null;
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

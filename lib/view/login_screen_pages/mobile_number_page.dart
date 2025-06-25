import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_aura/constant/asset_path.dart';
import 'package:the_aura/res/routes/routes_name.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/textfield/mobile_no_field_widget.dart';

class MobileNumberPage extends StatelessWidget {
  MobileNumberPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 130),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Image.asset(AssetPath.auraImage)),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  //
                  // input mobile number field
                  //
                  child: MobileNoFieldWidget(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: mobileNoController,
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
                ),
                const SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    textAlign: TextAlign.center,
                    "An OTP will be sent on given phone number for verification. Standard message and data rates apply.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: MyElevatedButtonWidget(
                    fontWeight: FontWeight.normal,
                    buttonName: "Login/Sign up",
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.offNamed(RoutesName.otpScreenPage);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

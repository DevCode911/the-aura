import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:the_aura/controller/otp_controller.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class OtpTextFieldWidget extends StatelessWidget {
  OtpTextFieldWidget({super.key});
  final otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Pinput(
          length: 4,
          controller: otpController.otpTextController,
          focusNode: otpController.otpFocusNode,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          autofocus: true,
          closeKeyboardWhenCompleted: true,
          showCursor: true,
          cursor: Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 2,
            height: 22,
            color: AppColors.lightPrimary,
          ),
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          defaultPinTheme: PinTheme(
            width: 68,
            height: 68,
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade50,
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 68,
            height: 68,
            textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.lightPrimary,
              fontWeight: FontWeight.w600,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.lightPrimary, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightPrimary.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          errorPinTheme: PinTheme(
            width: 68,
            height: 68,
            textStyle: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.red),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red),
              color: Colors.red.shade50,
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 68,
            height: 68,
            textStyle: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.green),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green),
              color: Colors.green.shade50,
            ),
          ),
          onChanged: (value) {
            otpController.setOtp(value);
          },
          onTapOutside: (event) {
            otpController.otpFocusNode.unfocus();
          },
        ),

        // Reactive error message
        Obx(() {
          return otpController.errorMessage.value.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  otpController.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
              )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}

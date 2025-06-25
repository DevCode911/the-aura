import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/bottom_navi_controller.dart';
import 'package:the_aura/utils/common_utils/snackbar/my_snackbar_widget.dart';

import '../res/routes/routes_name.dart';

class OtpController extends GetxController {
  final TextEditingController otpTextController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  final RxString otp = ''.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isVerifying = false.obs;

  final RxBool canResendOtp = false.obs;
  final RxInt resendCountdown = 30.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    _startResendCountdown();
  }

  @override
  void onClose() {
    otpTextController.dispose();
    otpFocusNode.dispose();
    _resendTimer?.cancel();
    super.onClose();
  }

  void setOtp(String value) {
    otp.value = value;
    errorMessage.value = ''; // Clear error when user starts typing
  }

  Future<void> verifyOtp() async {
    if (otp.value.length != 4) {
      errorMessage.value = 'Please enter a valid 4-digit OTP';
      return;
    }

    isVerifying.value = true;
    errorMessage.value = '';

    await Future.delayed(const Duration(milliseconds: 300)); // Simulate delay

    if (otp.value == '1234') {
      // Register controller before using BodyPage (if not already registered)
      if (!Get.isRegistered<BottomNaviController>()) {
        Get.put(BottomNaviController());
      }
      Get.offAllNamed(RoutesName.bodyPage);
    } else {
      errorMessage.value = 'Invalid OTP. Please try again';

      Future.delayed(const Duration(milliseconds: 650), () {
        otpTextController.clear();
        otp.value = '';
        otpFocusNode.requestFocus();
      });
    }

    isVerifying.value = false;
  }

  Future<void> resendOtp() async {
    if (!canResendOtp.value) return;

    canResendOtp.value = false;
    resendCountdown.value = 30;
    errorMessage.value = '';
    otpTextController.clear();
    otpFocusNode.requestFocus();

    // Simulate sending OTP
    await Future.delayed(const Duration(seconds: 1));
    _startResendCountdown();

    MySnackBarWidget.showSnackbar(
      title: "OTP",
      message: "A new OTP has been sent to your number",
    );
  }

  void _startResendCountdown() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

 
}

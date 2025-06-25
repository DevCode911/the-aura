// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:the_aura/controller/counter_button_controller.dart';
// import 'package:the_aura/controller/image_picker_controller.dart';
// import 'package:the_aura/controller/male_service_controller.dart';
// import 'package:the_aura/controller/otp_controller.dart';
// import 'package:the_aura/res/app_theme/app_colors.dart';
// import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
// import 'package:the_aura/utils/common_widgets/otp_widgets/otp_textfield_widget.dart';

// import '../../controller/api_controllers/category_controller.dart';
// import '../../controller/favourite_controller.dart';

// class OtpValidatePage extends StatelessWidget {
//   OtpValidatePage({super.key});

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final categoryController = Get.find<CategoryController>();
//   final maleServiceController = Get.find<MaleServiceController>();
//   final counterController = Get.find<CounterButtonController>();
//   final imagePickerController = Get.find<ImagePickerController>();
//   final favouriteController = Get.find<FavouriteController>();

//   // function : off A page and go B page
//   void navigationWithAnimation(Widget page) {
//     Get.off(
//       () => page,
//       transition: Transition.downToUp,
//       duration: const Duration(seconds: 2),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final otpController = Get.find<OtpController>();

//     final ThemeData theme = Theme.of(context);

//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,

//               children: [
//                 const Spacer(),
//                 Text(
//                   "Enter verification code",
//                   style: Theme.of(context).textTheme.headlineLarge,
//                 ),
//                 const SizedBox(height: 8),
//                 Text("We have sent you a 4 digit verification code on"),
//                 const SizedBox(height: 30),

//                 // Pinput widget here
//                 OtpTextFieldWidget(), // Otp field is here....

//                 const Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Didn't receive code?",
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     Obx(
//                       () => TextButton(
//                         onPressed:
//                             otpController.canResendOtp.value
//                                 ? () => otpController.resendOtp()
//                                 : null,
//                         child: Obx(
//                           () => Text(
//                             otpController.canResendOtp.value
//                                 ? "Resend"
//                                 : "Resend in ${otpController.resendCountdown.value}s",
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               color:
//                                   otpController.canResendOtp.value
//                                       ? AppColors.lightPrimary
//                                       : AppColors.grey,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 SizedBox(
//                   width: 300,
//                   child: MyElevatedButtonWidget(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         otpController.verifyOtp(); // vrify otp is here.........
//                       }
//                     },
//                     buttonName: 'Verify OTP',
//                     textStyle: Theme.of(context).textTheme.titleMedium,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

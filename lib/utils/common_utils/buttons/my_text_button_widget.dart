import 'package:flutter/material.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class MyTextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonName;
  final TextStyle? textStyle;

  const MyTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.buttonName,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      onPressed: onPressed,
      child: Text(
        buttonName,
        style:
            textStyle ??
            TextStyle(
              fontSize: 16,
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

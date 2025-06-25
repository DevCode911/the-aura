import 'package:flutter/material.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class MyElevatedButtonWidget extends StatelessWidget {
  const MyElevatedButtonWidget({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.fontSize,
    this.icon,
    this.isIcon = false,
    this.fontWeight,
    this.textStyle,
    this.buttonStyle,
    this.image,
  });
  final String buttonName;
  final VoidCallback? onPressed;
  final double? fontSize;
  final IconData? icon;
  final bool? isIcon;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
          buttonStyle ??
          ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: Theme.of(context).textTheme.headlineSmall,
          ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(image!, height: 50, width: 50),
            ),
          Text(buttonName, style: textStyle),
          if (isIcon == true)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                icon,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.lightTextcolor
                        : AppColors.lightTextcolor,
                size: 14,
              ),
            ),
        ],
      ),
    );
  }
}

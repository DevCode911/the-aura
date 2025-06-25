import 'package:flutter/material.dart';

class MyIconButtonWidget extends StatelessWidget {
  const MyIconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
    );
  }
}

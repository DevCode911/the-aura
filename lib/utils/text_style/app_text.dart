import 'package:flutter/material.dart';

enum TextSize { small, medium, large }

class AppText extends StatelessWidget {
  final String text;
  final TextSize size;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;

  const AppText({
    super.key,
    required this.text,
    this.size = TextSize.medium,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.textAlign,
  });


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,

      
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}

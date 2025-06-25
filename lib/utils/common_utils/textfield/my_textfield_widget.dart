import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class MyTextfieldWidget extends StatelessWidget {
  const MyTextfieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.label,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.lightPrimary,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      validator: validator,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.transparent,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightPrimary, width: 1),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}

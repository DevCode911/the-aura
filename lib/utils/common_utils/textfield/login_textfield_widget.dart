import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class LoginTextFieldWidget extends StatelessWidget {
  const LoginTextFieldWidget({
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
      style: const TextStyle(fontSize: 13),

      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.headlineSmall,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.transparent,

        // 👇 Updated all borders to Outline
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../res/app_theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key, this.controller, this.hintText});
  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.lightPrimary,
      controller: controller,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

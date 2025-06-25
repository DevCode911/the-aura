import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class MobileNoFieldWidget extends StatelessWidget {
  const MobileNoFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        isDense: true,
        hintText: "Mobile Number",
        hintStyle: Theme.of(context).textTheme.titleSmall,
        contentPadding: const EdgeInsets.only(left: 12, top: 25, bottom: 16),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black)),
                ),
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  '+91',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.lightPrimary),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../res/app_theme/app_colors.dart';

class ListTileWidgets extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? mobileNo;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? tileColor;
  final Widget? trailing;

  const ListTileWidgets({
    super.key,
    required this.title,
    this.icon,
    this.subtitle,
    this.onTap,
    this.tileColor,
    this.mobileNo,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      tileColor: tileColor,
      leading: Icon(icon, color: AppColors.lightPrimary),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
          color: AppColors.lightPrimary,
        ),
      ),
      subtitle:
          (subtitle != null || mobileNo != null)
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (subtitle != null) Text(subtitle!),
                  if (mobileNo != null) Text("Phone No : $mobileNo"),
                ],
              )
              : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
    );
  }
}

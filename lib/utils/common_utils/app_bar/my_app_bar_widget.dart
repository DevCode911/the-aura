import 'package:flutter/material.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

class MyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarWidget({
    super.key,
    this.appBarName,
    this.actions,
    this.showBackButton = true, // 👈 Control back arrow
  });

  final String? appBarName;
  final List<Widget>? actions;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton, // 👈 hides back arrow if false

      actions: actions,
      title: Text(
        appBarName ?? '',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 0.7,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade900
                  : AppColors.lightPrimary.withAlpha(60),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}

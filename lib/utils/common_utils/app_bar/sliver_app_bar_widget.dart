import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/app_theme/app_colors.dart';
import '../buttons/my_icon_button_widget.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String? title;
  final String imagePath;
  final VoidCallback? onBack;
  final double expandedHeight;

  const SliverAppBarWidget({
    super.key,
    this.title,
    required this.imagePath,
    this.onBack,
    this.expandedHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,

      expandedHeight: expandedHeight,

      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: MyIconButtonWidget(
          onPressed: onBack ?? () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      title:
          title != null
              ? Text(
                title!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
              : null,

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [Image.asset(imagePath, fit: BoxFit.cover)],
        ),
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
}

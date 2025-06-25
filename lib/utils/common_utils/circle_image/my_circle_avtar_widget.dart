import 'package:flutter/material.dart';

class MyCircleAvtarWidget extends StatelessWidget {
  final String imagePath;

  const MyCircleAvtarWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 260,
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            shape: BoxShape.circle,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(255),
          child: Image.asset(imagePath, height: 230),
        ),
      ],
    );
  }
}

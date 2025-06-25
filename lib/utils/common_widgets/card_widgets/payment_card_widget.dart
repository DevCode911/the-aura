import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/app_theme/app_colors.dart';
import '../../../view_models/category/category.dart';
import '../../../view_models/services/service_controller.dart';
import '../../../view_models/services/service_model.dart';

class PaymentCardWidget extends StatelessWidget {
  PaymentCardWidget({super.key});

  final serviceController = Get.find<ServiceController>();
  final Map arguments = Get.arguments as Map;
  late final Category category =
      arguments['category'] is Category
          ? arguments['category']
          : Category(name: "Service");
  late final List<Service> selectedServices = List<Service>.from(
    arguments['selectedServices'] ?? [],
  );

  @override
  Widget build(BuildContext context) {
    double itemTotal = serviceController.calculation(
      category.name!.toLowerCase(),
    );
    double discount = serviceController.discount(category.name!.toLowerCase());
    final grandTotal = itemTotal - discount;

    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
        border: Border.all(color: AppColors.grey.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          rowText("Item Total", "₹ ${itemTotal.toStringAsFixed(0)}"),
          rowText("Item Discount", "₹ ${discount.toStringAsFixed(0)}"),
          rowText("Service Fee", "₹ 0"),
          rowText("Tax", "₹ 0"),

          // Grand Total with bold text
          rowText(
            "Grand Total",
            "₹ ${grandTotal.toStringAsFixed(0)}",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

Widget rowText(String heading, String content, {TextStyle? style}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(heading, style: style)),
        Text(content, style: style),
      ],
    ),
  );
}

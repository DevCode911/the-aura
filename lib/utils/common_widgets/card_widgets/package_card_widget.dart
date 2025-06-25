import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/utils/common_utils/buttons/counter_button_widget.dart';
import 'package:the_aura/view_models/packages/packages_model.dart';
import '../../../controller/male_service_controller.dart';
import '../../../res/app_theme/app_colors.dart';

class PackageCardWidget extends StatelessWidget {
  final PackageData? packages;

  PackageCardWidget({super.key, this.packages});

  final maleServiceController = Get.find<MaleServiceController>();

  @override
  Widget build(BuildContext context) {
    double? price = packages?.price;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black 
                : Colors.white,
        border: Border.all(color: AppColors.grey.withAlpha(80)),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Category
          Row(
            children: [
              Text(
                packages?.name ?? "No services",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              if (packages?.categoryData?.name != null)
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary.withAlpha(20),
                    border: Border.all(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.grey.withAlpha(80)
                              : AppColors.lightPrimary,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 40,
                  width: 73,
                  child: Text(packages!.categoryData!.name.toString()),
                ),
            ],
          ),

          const SizedBox(height: 10),

          //  Price, Discount, Duration, and Counter
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "₹ ${price?.toStringAsFixed(2) ?? '0.00'}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: AppColors.lightPrimary,
                ),
              ),
              const SizedBox(width: 10),

              Text(
                "₹ ${packages!.discount!.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 10),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 10),

          //  Description
          Text(
            packages?.description?.isNotEmpty == true
                ? packages!.description!
                : "No description available",
            style: const TextStyle(fontSize: 12),
          ),

          //  Services List
          if (packages?.serviceData != null &&
              packages!.serviceData!.isNotEmpty)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Included Services:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 5),
                    ...packages!.serviceData!.map(
                      (service) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          "• ${service.serviceName ?? 'Unnamed service'}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CounterButtonWidget(packageData: packages),
              ],
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/bottom_sheet_card_widget.dart';
import 'package:the_aura/view_models/services/service_model.dart';
import '../../../view_models/services/service_controller.dart';

class ServiceCarddWidget extends StatelessWidget {
  final Service? service;
  final String? imageUrl;
  final String? serviceName;
  final String? serviceType;
  final double? price;
  final double? discountPrice;
  final String? timeDuration;
  final String? description;
  final VoidCallback? onAdd;
  final bool? isSelected;

  const ServiceCarddWidget({
    super.key,
    this.imageUrl,
    this.serviceName,
    this.serviceType,
    this.price,
    this.discountPrice,
    this.description,
    this.timeDuration,
    this.onAdd,
    this.service,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.find<ServiceController>();

    return Obx(() {
      final isSelected =
          service != null &&
          (serviceController.maleSelectedServices.any(
                (s) => s.id == service!.id,
              ) ||
              serviceController.womenSelectedServices.any(
                (s) => s.id == service!.id,
              ));

      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.grey.withAlpha(100)),
        ),
        // Moved outside of decoration
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title + Image Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Title and Rating
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName ?? "Unnamed Service",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text("4.8 (23k)", style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right: Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    frameBuilder: (
                      BuildContext context,
                      Widget child,
                      int? frame,
                      bool wasSynchronouslyLoaded,
                    ) {
                      if (wasSynchronouslyLoaded) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        child: child,
                      );
                    },
                    errorBuilder:
                        (_, __, ___) => Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image),
                        ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Price
            Row(
              children: [
                Text(
                  "₹${price?.toStringAsFixed(0) ?? '0'}",
                  style: const TextStyle(
                    color: AppColors.lightPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "₹${discountPrice?.toStringAsFixed(0) ?? '0'}",
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Duration
            Row(
              children: [
                const Text("Duration : ", style: TextStyle(fontSize: 13)),
                Text(
                  timeDuration ?? '0 mins',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// View Details
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return BottomSheetCardWidget(
                      service: service,
                      description: description,
                      discount: discountPrice?.toStringAsFixed(0),
                      imageUrl: imageUrl,
                      price: price?.toStringAsFixed(0),
                      serviceName: serviceName,
                      timeDuration: timeDuration,
                    );
                  },
                );
              },
              child: Text(
                "View Details",
                style: TextStyle(
                  color: AppColors.lightPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),

            const SizedBox(height: 6),

            /// Description
            Text(
              description ?? "No description available",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            /// Add Button
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 35,
                child: MyElevatedButtonWidget(
                  buttonName: isSelected ? "✓ Added" : "+ Add",
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSelected ? Colors.green : AppColors.lightPrimary,
                  ),
                  onPressed: onAdd,
                  textStyle: const TextStyle(
                    color: AppColors.lightTextcolor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

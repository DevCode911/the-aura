import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/male_service_controller.dart';
import 'package:the_aura/controller/add_service_controller.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/view_models/service_details/service_details_model.dart';
import '../../../view_models/services/service_controller.dart';
import '../../../view_models/services/service_model.dart';
import '../../../view_models/sub_category_service/sub_category_controller.dart';

class BottomSheetCardWidget extends StatelessWidget {
  final Service? service;

  final String? serviceName;
  final String? price;
  final String? discount;
  final String? timeDuration;
  final String? imageUrl;
  final String? description;
  final Data? serviceDetails;

  BottomSheetCardWidget({
    super.key,
    this.serviceName,
    this.price,
    this.discount,
    this.timeDuration,
    this.imageUrl,
    this.description,
    this.serviceDetails,
    this.service,
  });

  final maleServiceController = Get.find<MaleServiceController>();
  final addServiceController = Get.find<AddServiceController>();
  final viewServiceController = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    final List<String> points = (description ?? "").split(',');

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///  Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl ?? "",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Center(
                        child: Icon(Icons.broken_image, size: 40),
                      ),
                ),
              ),

              ///  Scrollable Details
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///  Service Name
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              serviceName ?? "Unnamed Service",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          // add service button
                          Obx(() {
                            final serviceController =
                                Get.find<ServiceController>();
                            final isSelected = serviceController
                                .selectedServices
                                .contains(service);

                            return SizedBox(
                              width: 85,
                              height: 45,
                              child: MyElevatedButtonWidget(
                                buttonName: isSelected ? "✓ Added" : "+ Add",
                                textStyle: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : AppColors.lightPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                                buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isSelected
                                          ? Colors.green
                                          : AppColors.lightTextcolor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color:
                                          isSelected
                                              ? Colors.green
                                              : AppColors.lightPrimary,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (service != null) {
                                    if (isSelected) {
                                      serviceController.addService(service!);
                                    } else {
                                      serviceController.addService(service!);
                                    }
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),

                      const SizedBox(height: 10),

                      ///  Price & Discount
                      Row(
                        children: [
                          Text(
                            "₹${price ?? "0"}",
                            style: const TextStyle(
                              color: AppColors.lightPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (discount != null && discount != price)
                            Text(
                              "₹$discount",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      ///  Duration
                      Row(
                        children: [
                          const Text(
                            "Duration: ",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            timeDuration ?? "0 mins",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// Description Points
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: points.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "• ${points[index].trim()}",
                              style: const TextStyle(fontSize: 14),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        },
                      ),

                      // const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

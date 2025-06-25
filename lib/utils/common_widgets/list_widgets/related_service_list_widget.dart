import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/view_models/services/service_model.dart';
import '../../../res/app_theme/app_colors.dart';
import '../../common_utils/buttons/my_elevated_button_widget.dart';
import '../../../view_models/sub_category_service/sub_category_controller.dart';

class RelatedServiceListWidget extends StatelessWidget {
  final List<Service> selectedServices;
  final bool isForMen;

  RelatedServiceListWidget({
    super.key,
    required this.selectedServices,
    this.isForMen = true,
  });

  final viewServiceController = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.25;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: selectedServices.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final service = selectedServices[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: AppColors.grey.withAlpha(50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  child: Image.network(
                    service.image?.startsWith('http') == true
                        ? service.image!
                        : "https://yourdomain.com/${service.image ?? ''}",
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => const SizedBox(
                          height: 150,
                          child: Center(
                            child: Icon(Icons.broken_image, size: 40),
                          ),
                        ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.serviceName ?? "Unnamed Service",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(() {
                            final isSelected = viewServiceController
                                .selectedServices
                                .any((e) => e.id == service.id);

                            return SizedBox(
                              width: 100,
                              height: 50,
                              child: MyElevatedButtonWidget(
                                buttonName: isSelected ? "Added" : "Add",
                                textStyle: TextStyle(
                                  color:
                                      isSelected
                                          ? AppColors.done
                                          : AppColors.lightPrimary,
                                ),
                                buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isSelected
                                          ? Colors.white
                                          : AppColors.lightTextcolor,
                                ),
                                onPressed: () {
                                  if (!isSelected) {
                                    // viewServiceController.addService(
                                    //   selectedServices,
                                    // );
                                  }
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "₹ ${service.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.lightPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        service.description ?? '',
                        style: const TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

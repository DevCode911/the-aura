import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/utils/common_utils/buttons/my_icon_button_widget.dart';
import '../../../res/api_urls/api_url.dart';
import '../../../res/app_theme/app_colors.dart';
import '../../../view_models/services/service_controller.dart';
import '../../../view_models/services/service_model.dart';

class SelectedServiceListWidget extends StatelessWidget {
  final List<Service> selectedServices;

  SelectedServiceListWidget({super.key, required this.selectedServices});
  final serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final service = selectedServices[index];
        final imageUrl =
            "${ApiUrl.baseUrl}${service.image!.startsWith("/") ? "" : "/"}${service.image}";

        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 75,
                    width: 75,
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
                        child: child,
                      );
                    },
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 40),
                  ),
                ),
                const SizedBox(width: 16),

                //  Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  Name
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              service.serviceName ?? 'Unnamed Service',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          MyIconButtonWidget(
                            onPressed: () {
                              serviceController.addService(
                                selectedServices.removeAt(index),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      //  Subcategory (ServiceDetails)
                      if (service.subCategoryData?.name != null)
                        Text(
                          "Subcategory: ${service.subCategoryData!.name!}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey,
                          ),
                        ),

                      //  Duration
                      if (service.timeDuration != null &&
                          service.timeDuration!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            "Duration: ${service.timeDuration} ",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                      // Price & Discount
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Text(
                              "₹${service.price?.toStringAsFixed(0) ?? '0'}",
                              style: const TextStyle(
                                color: AppColors.lightPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "₹${service.discount?.toStringAsFixed(0) ?? '0'}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //  Description
                      if (service.description != null &&
                          service.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: ReadMoreText(service.description!),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, childCount: selectedServices.length),
    );
  }
}

class ReadMoreText extends StatelessWidget {
  final String text;

  ReadMoreText(this.text, {super.key});

  final RxBool isExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (text.length <= 50) {
        return Text(text, style: Theme.of(context).textTheme.bodyMedium);
      }

      final shortText = text.substring(0, 50);

      return GestureDetector(
        onTap: () => isExpanded.toggle(),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(text: isExpanded.value ? text : "$shortText..."),
              TextSpan(
                text: isExpanded.value ? "Read less" : "Read more",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.lightPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

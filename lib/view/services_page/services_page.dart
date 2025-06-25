import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/dialog_box/alert_dialog_box.dart';

import '../../res/api_urls/api_url.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/common_widgets/card_widgets/service_cardd_widget.dart';
import '../../view_models/category/category.dart';
import '../../view_models/services/service_controller.dart';

class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  final ServiceController serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments ?? {};
    final subCategory = arguments['subCategory'];
    final subCategoryName = subCategory?.name ?? 'Services';
    //
    final category = arguments['category'] as Category?;
    final categoryName =
        arguments['categoryName'] as String? ?? category?.name ?? 'Services';
    return Scaffold(
      appBar: MyAppBarWidget(appBarName: subCategoryName),
      body: Obx(() {
        if (serviceController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredServices =
            serviceController.services
                .where((s) => s.subCategoryData?.id == subCategory?.id)
                .toList();

        if (filteredServices.isEmpty) {
          return const Center(child: Text("No services available"));
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 80,
              ),
              child: ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  final imageUrl =
                      (service.image != null && service.image!.isNotEmpty)
                          ? (service.image!.startsWith("http")
                              ? service.image!
                              : "${ApiUrl.baseUrl}/${service.image}")
                          : "https://demofree.sirv.com/nope-not-here.jpg";

                  final categoryNameLower =
                      service.categoryData?.name?.toLowerCase() ?? '';
                  final isSelected =
                      categoryNameLower == 'men'
                          ? serviceController.maleSelectedServices.any(
                            (s) => s.id == service.id,
                          )
                          : categoryNameLower == 'women'
                          ? serviceController.womenSelectedServices.any(
                            (s) => s.id == service.id,
                          )
                          : false;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ServiceCarddWidget(
                      description: service.description,
                      discountPrice: service.discount!.toDouble(),
                      price: service.price!.toDouble(),
                      serviceName: service.serviceName,
                      serviceType: service.serviceType,
                      timeDuration: service.timeDuration,
                      service: service,
                      imageUrl: imageUrl,
                      isSelected: isSelected,
                      onAdd: () {
                        serviceController.addService(service);
                      },
                    ),
                  );
                },
              ),
            ),

            // Proceed button
            // Positioned(
            //   bottom: 15,
            //   left: 15,
            //   right: 15,
            //   child: Obx(() {
            //     final count =
            //         serviceController.selectedServices
            //             .where(
            //               (service) =>
            //                   service.subCategoryData?.id == subCategory?.id,
            //             )
            //             .length;

            //     final buttonText = count > 0 ? "Proceed ($count)" : "Proceed";

            //     return SizedBox(
            //       height: 45,
            //       child: MyElevatedButtonWidget(
            //         buttonName: buttonText,
            //         textStyle: Theme.of(
            //           context,
            //         ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            //         onPressed: () {
            //           if (count == 0) {
            //             AlertDialogBox.showAlertBox(context);
            //           } else {
            //             Get.toNamed(
            //               RoutesName.summaryPage,
            //               arguments: {
            //                 'category': category,
            //                 'categoryName': categoryName,
            //                 'subCategory': subCategory,
            //                 'selectedServices':
            //                     serviceController.selectedServices
            //                         .where(
            //                           (s) =>
            //                               s.subCategoryData?.id ==
            //                               subCategory?.id,
            //                         )
            //                         .toList(),
            //               },
            //             );
            //           }
            //         },
            //       ),
            //     );
            //   }),
            // ),
            // categoryName should be 'Men' or 'Women' (case-insensitive)
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Obx(() {
                final count = serviceController.selectedCount(categoryName);

                final buttonText = count > 0 ? "Proceed ($count)" : "Proceed";

                return SizedBox(
                  height: 45,
                  child: MyElevatedButtonWidget(
                    buttonName: buttonText,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                    onPressed: () {
                      if (count == 0) {
                        AlertDialogBox.showAlertBox(context);
                      } else {
                        final selectedServices =
                            categoryName.toLowerCase() == 'men'
                                ? serviceController.maleSelectedServices
                                : serviceController.womenSelectedServices;

                        Get.toNamed(
                          RoutesName.summaryPage,
                          arguments: {
                            'category': category,
                            'categoryName': categoryName,
                            'subCategory': subCategory,
                            'selectedServices': selectedServices.toList(),
                          },
                        );
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

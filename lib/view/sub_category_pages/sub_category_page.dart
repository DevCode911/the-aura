import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_icon_button_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/category_card_widget.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_controller.dart';
import '../../controller/add_service_controller.dart';
import '../../controller/male_service_controller.dart';
import '../../res/routes/routes_name.dart';
import '../../utils/common_utils/app_bar/my_app_bar_widget.dart';
import '../../utils/common_utils/buttons/my_elevated_button_widget.dart';
import '../../view_models/category/category.dart';
import '../../view_models/services/service_controller.dart';

class SubCategoryPage extends StatelessWidget {
  SubCategoryPage({super.key});
  final Category category =
      Get.arguments['category'] ?? Category(name: "Service");
  final maleServiceController = Get.find<MaleServiceController>();
  final addServiceController = Get.find<AddServiceController>();
  final viewServiceController = Get.find<SubCategoryController>();
  final serviceController = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    final isShopCategory = category.name?.toLowerCase() == 'shop';
    final categoryName = category.name?.toLowerCase() ?? 'service';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBarWidget(
        appBarName:
            categoryName == 'service'
                ? "All Services"
                : "All ${category.name} Services",
        actions:
            isShopCategory
                ? [
                  MyIconButtonWidget(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Get.toNamed(
                        RoutesName.addToCartPage,
                        arguments: {
                          'category': category,
                          'selectedServices':
                              viewServiceController.cardList.toList(),
                        },
                      );
                    },
                  ),
                ]
                : null,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: 80,
            ),
            child: Column(
              children: [
                if (!isShopCategory)
                  Column(
                    children: [
                      SizedBox(
                        height: 45,
                        child: MyElevatedButtonWidget(
                          buttonName: "\u2B50 Premium Packages",
                          textStyle:
                              MediaQuery.of(context).size.width > 600
                                  ? Theme.of(context).textTheme.headlineSmall!
                                      .copyWith(color: AppColors.lightTextcolor)
                                  : Theme.of(
                                    context,
                                  ).textTheme.headlineSmall!.copyWith(
                                    color: AppColors.lightTextcolor,
                                  ),
                          onPressed: () {
                            Get.toNamed(
                              RoutesName.packagesPage,
                              arguments: {
                                'showBackArrow': true,
                                "TypeOfservice": categoryName,
                                "isFilterData": true,
                              },
                            );
                          },
                          isIcon: true,
                          icon: Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),

                Expanded(
                  child: Obx(() {
                    if (viewServiceController.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.lightPrimary,
                        ),
                      );
                    }

                    // Filter services by the selected category
                    final filteredServices =
                        viewServiceController.categoryServices
                            .where(
                              (service) =>
                                  service.categoryData?.name?.toLowerCase() ==
                                  categoryName,
                            )
                            .toList();

                    // Show message when no services are available
                    if (filteredServices.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 60,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No services available',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Check back later or try another category',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 15),
                      itemCount: filteredServices.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.90,
                          ),
                      itemBuilder: (context, index) {
                        final service = filteredServices[index];
                        return CategoryCardWidget(
                          subCategoryData: service,
                          category: category,
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 15,
          //   left: 15,
          //   right: 15,
          //   child: Obx(() {
          //     final count = serviceController.selectedCount(categoryName);
          //     return SizedBox(
          //       height: 45,
          //       child: MyElevatedButtonWidget(
          //         buttonName: count > 0 ? "Proceed ($count)" : "Proceed",
          //         textStyle: Theme.of(
          //           context,
          //         ).textTheme.headlineSmall!.copyWith(color: Colors.white),
          //         onPressed: () {
          //           if (count == 0) {
          //             AlertDialogBox.showAlertBox(context);
          //           } else {
          //             Get.toNamed(
          //               RoutesName.summaryPage,
          //               arguments: {
          //                 'selectedServices':
          //                     serviceController.selectedServices
          //                         .where(
          //                           (service) =>
          //                               service.categoryData?.name
          //                                   ?.toLowerCase() ==
          //                               categoryName,
          //                         )
          //                         .toList(),
          //                 'subCategory': subCategory,
          //               },
          //             );
          //           }
          //         },
          //       ),
          //     );
          //   }),
          // ),
        ],
      ),
    );
  }
}

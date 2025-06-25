import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/package_card_widget.dart';
import 'package:the_aura/view_models/packages/packages_controller.dart';
import '../../../controller/counter_button_controller.dart';

class PackagesPage extends StatelessWidget {
  final bool? showBackArrow;
  final String? categoryType;
  PackagesPage({super.key, this.showBackArrow = false, this.categoryType});
  final packagesController = Get.find<PackagesController>();
  final counterController = Get.find<CounterButtonController>();

  @override
  Widget build(BuildContext context) {
    // Get categoryType and trigger fetch
    final arguments = Get.arguments ?? {};
    final showBackArrow = arguments['showBackArrow'] ?? false;
    final catName = arguments["TypeOfservice"];
    final isFilterData = arguments["isFilterData"] ?? false;

    final filterPackeges =
        packagesController.packagesList
            .where(
              (pakeg) => pakeg.categoryData!.name!.toLowerCase() == catName,
            )
            .toList();

    return Scaffold(
      appBar: MyAppBarWidget(
        appBarName: "Packages",
        showBackButton: showBackArrow,
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 30,
                    ),
                    child: Obx(
                      () =>
                          packagesController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : packagesController.packagesList.isEmpty
                              ? const Center(
                                child: Text(
                                  "No packages available",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                              : ListView.builder(
                                padding: const EdgeInsets.only(bottom: 70),

                                itemCount:
                                    isFilterData
                                        ? filterPackeges.length
                                        : packagesController
                                            .packagesList
                                            .length,
                                itemBuilder: (context, index) {
                                  final packages =
                                      isFilterData
                                          ? filterPackeges[index]
                                          : packagesController
                                              .packagesList[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: PackageCardWidget(
                                      packages: packages,
                                    ),
                                  );
                                },
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.grey.withAlpha(80)
                                : AppColors.lightPrimary,
                      ),
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.lightTextcolor
                              : AppColors.lightTextcolor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () => Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "₹ ${counterController.totalPrice.value.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.lightPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: MyElevatedButtonWidget(
                    buttonName: "View Booking",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

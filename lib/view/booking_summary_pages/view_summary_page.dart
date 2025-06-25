import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/bottm_sheet_card_adrees_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/payment_card_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/summary_card_add_widget.dart';
import 'package:the_aura/view_models/category/category.dart';
import 'package:the_aura/view_models/services/service_controller.dart';
import 'package:the_aura/view_models/services/service_model.dart';
import '../../utils/common_widgets/list_widgets/selected_service_list_widget.dart';

class ViewSummaryPage extends StatelessWidget {
  ViewSummaryPage({super.key, this.category});

  final arguments = Get.arguments ?? {};
  final serviceController = Get.find<ServiceController>();
  final Category? category;

  late final List<Service> selectedServices = List<Service>.from(
    arguments['selectedServices'] ?? [],
  );

  @override
  Widget build(BuildContext context) {
    final category = arguments['category'] as Category;
    final filteredServices = serviceController.getServicesByCategory(
      category.name ?? '',
    );
    final services =
        filteredServices
            .where((services) => !selectedServices.contains(services))
            .toList();

    return Scaffold(
      appBar: MyAppBarWidget(appBarName: "View Summary ${category.name}"),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          /// Scrollable content
          Padding(
            padding: const EdgeInsets.only(bottom: 80), // space for buttons
            child: CustomScrollView(
              slivers: [
                /// Selected Services
                SelectedServiceListWidget(selectedServices: selectedServices),

                /// Recommended Services
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (services.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13),
                            child: Text(
                              "Recommended",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        SizedBox(
                          height: services.isEmpty ? 0 : 210,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              final serviceData = services[index];
                              return SizedBox(
                                width: 170,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: SummaryCardAddWidget(
                                    service: serviceData,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Payment Card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: PaymentCardWidget(),
                  ),
                ),
              ],
            ),
          ),

          /// Fixed bottom buttons
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                children: [
                  /// Schedule for Later button
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: MyElevatedButtonWidget(
                        buttonName: "Schedule for Later",
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => BottmSheetCardAdreesWidget(),
                          );
                        },
                        buttonStyle: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.lightText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppColors.grey.withAlpha(80)
                                      : AppColors.lightText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// Request Now button
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: MyElevatedButtonWidget(
                        buttonStyle: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.done,
                        ),
                        buttonName: "Request Now",
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

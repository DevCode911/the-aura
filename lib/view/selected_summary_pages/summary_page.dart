import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/constant/asset_path.dart';
import 'package:the_aura/res/routes/routes_name.dart';
import 'package:the_aura/utils/common_utils/app_bar/sliver_app_bar_widget.dart';
import 'package:the_aura/utils/common_widgets/list_widgets/selected_service_list_widget.dart';
import 'package:the_aura/view_models/services/service_model.dart';

import '../../utils/common_utils/buttons/my_elevated_button_widget.dart';
import '../../view_models/category/category.dart';

class SummaryPage extends StatelessWidget {
  SummaryPage({super.key});

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsing AppBar
          SliverAppBarWidget(
            imagePath: AssetPath.summary,
            expandedHeight: 300,
            title: "Summary",
          ),

          // Category Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                "| Salon For ${category.name}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),

          // Selected Services
          SelectedServiceListWidget(selectedServices: selectedServices),
        ],
      ),

      //  Bottom Navigation Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: MyElevatedButtonWidget(
            buttonName: "View Summary",
            textStyle: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(color: Colors.white),
            onPressed: () {
              Get.toNamed(
                RoutesName.viewSummaryPage,
                arguments: {
                  'selectedServices': selectedServices.toList(),
                  'category': category,
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

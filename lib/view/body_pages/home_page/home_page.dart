import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:the_aura/constant/asset_path.dart';
import 'package:the_aura/controller/favourite_controller.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/respository/addvertisment/addvertisment_controller.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/category_card_widget.dart';

import '../../../res/api_urls/api_url.dart';
import '../../../view_models/category/category_controller.dart';
import '../../../view_models/services/service_controller.dart';
import '../../../view_models/sub_category_service/sub_category_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    categoryController.fetchCategories();
    serviceController.fetchServices();
    subCategoryController.fetchCategoryData();
  }

  final serviceController = Get.find<ServiceController>();
  final categoryController = Get.find<CategoryController>();
  final subCategoryController = Get.find<SubCategoryController>();

  final favouriteController = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(71),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 4,
          title: Row(
            children: [
              Image.asset(AssetPath.auraImage, height: 50),
              const SizedBox(width: 12),
              Text(
                "The Aura",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightPrimary,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 0.7,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade900
                      : AppColors.lightPrimary.withAlpha(60),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LiquidPullToRefresh(
          onRefresh: () async {
            await categoryController.fetchCategories;
            await serviceController.fetchServices;
          },
          height: 100,
          animSpeedFactor: 2,
          backgroundColor: AppColors.lightPrimary,
          color: Colors.transparent,
          showChildOpacityTransition: false,
          springAnimationDurationInMilliseconds: 700,

          //  Wrap a ListView here
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              const SizedBox(height: 15),
              addSlider(),
              const SizedBox(height: 30),

              //  Grid View of Home Categories
              Obx(() {
                final isLoading = categoryController.isLoading.value;
                final categories = categoryController.categoryList;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: isLoading ? 2 : categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.90,
                        ),

                    itemBuilder: (context, index) {
                      if (isLoading) {
                        return CategoryCardLoadingWidget();
                      }
                      final category = categories[index];
                      return CategoryCardWidget(
                        category: category,
                        goToSubCategoryPage: false,
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// add slider
Widget addSlider() {
  final addvertismnetController = Get.find<AddvertismentController>();

  return Obx(() {
    final imageList = addvertismnetController.addsList;

    if (imageList.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: AddSliderLoadingWidget()),
      );
    }

    return CarouselSlider(
      items:
          imageList.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: Container(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade900
                              : Colors.grey.shade300,
                      child: Image.network(
                        "${ApiUrl.baseUrl}/${url.image}",
                        fit: BoxFit.cover,
                        frameBuilder: (
                          BuildContext context,
                          Widget child,
                          int? frame,
                          bool wasSynchronouslyLoaded,
                        ) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                            child: child,
                          );
                        },
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(seconds: 2),
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
    );
  });
}

class AddSliderLoadingWidget extends StatelessWidget {
  const AddSliderLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.grey.shade300,
      width: double.infinity,
    );
  }
}

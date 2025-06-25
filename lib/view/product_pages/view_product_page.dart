import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_aura/controller/view_product_controller.dart';
import 'package:the_aura/res/api_urls/api_url.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_controller.dart';
import '../../controller/favourite_controller.dart';
import '../../utils/common_utils/buttons/my_icon_button_widget.dart';
import '../../view_models/sub_category_service/sub_category_model.dart';

class ViewProductPage extends StatelessWidget {
  ViewProductPage({super.key});

  final favouriteController = Get.find<FavouriteController>();
  final viewProductController = Get.find<ViewProductController>();
  final viewServiceController = Get.find<SubCategoryController>();

  final Data? service = Get.arguments;
  @override
  Widget build(BuildContext context) {
    if (service == null) {
      return const Scaffold(body: Center(child: Text("Service not found")));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBarWidget(appBarName: "All Products"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 400, // ✅ Fix CarouselSlider layout
                child: imageSlider(context, viewServiceController),
              ),
              const SizedBox(height: 16),

              // indicator
              Center(child: imageIndicator(context, viewServiceController)),
              const SizedBox(height: 30),

              // product name and price
              productNamePrice(context, viewServiceController),
              const SizedBox(height: 30),

              // policcys of products
              productsPolicys(context),
              const SizedBox(height: 30),

              // buy and cart button
              buyAndCartbutton(context, service!),

              const SizedBox(height: 30),
              // product details
              productDetails(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// image slider widget
Widget imageSlider(
  BuildContext context,
  SubCategoryController viewServiceController,
) {
  return CarouselSlider(
    options: CarouselOptions(
      height: 400,
      enlargeCenterPage: true,
      autoPlay: false,
      aspectRatio: 16 / 9,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: const Duration(seconds: 2),
      viewportFraction: 1.0,
      onPageChanged: (index, reason) {
        viewServiceController.updatePageIndex(index);
      },
    ),
    items:
        viewServiceController.categoryServices.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.grey.withAlpha(50),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "${ApiUrl.baseUrl}/${url.image}",
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                  ),
                ),
              );
            },
          );
        }).toList(),
  );
}

// indicator widget
Widget imageIndicator(
  BuildContext context,
  SubCategoryController viewServiceController,
) {
  return Obx(
    () => AnimatedSmoothIndicator(
      activeIndex: viewServiceController.currentIndex.value,
      count: viewServiceController.categoryServices.length,
      effect: const ExpandingDotsEffect(
        activeDotColor: AppColors.lightPrimary,
        dotColor: AppColors.accent,
        dotHeight: 8,
        dotWidth: 8,
        spacing: 8,
        expansionFactor: 3,
      ),
    ),
  );
}

// product details, like share and add more container
Widget productNamePrice(
  BuildContext context,
  SubCategoryController viewServiceController,
) {
  final Data? service = Get.arguments;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                service!.name ?? 'Service Name Not Available',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Obx(
              () => MyIconButtonWidget(
                icon: Icon(
                  viewServiceController.whishList.any(
                        (element) => element.id == service.id,
                      )
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: AppColors.lightPrimary,
                ),
                onPressed: () {
                  viewServiceController.toggleFavourite(service);
                },
              ),
            ),
            MyIconButtonWidget(
              onPressed: () {},
              icon: Icon(Icons.share, color: AppColors.lightPrimary),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text("300+ bought next month"),
        const SizedBox(height: 10),
        if (service.name != null)
          Text(
            "Price: \u20B9 ${service.name}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.lightPrimary,
            ),
          ),
        const SizedBox(height: 10),
        // CounterButtonWidget(packageData: paca),
      ],
    ),
  );
}

Widget productsPolicys(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        "Cash On Delivery",
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      Text("7 Days Return", style: Theme.of(context).textTheme.headlineSmall),
      Text("Law Price", style: Theme.of(context).textTheme.headlineSmall),
    ],
  );
}

Widget buyAndCartbutton(BuildContext context, Data services) {
  final viewServiceController = Get.find<SubCategoryController>();

  // final addToCartController = Get.find<AddCartController>();
  return Column(
    children: [
      MyElevatedButtonWidget(buttonName: "Buy Now", onPressed: () {}),
      const SizedBox(height: 10),

      MyElevatedButtonWidget(
        buttonStyle: ElevatedButton.styleFrom(
          foregroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightTextcolor
                  : AppColors.lightText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColors.grey.withAlpha(80)
                      : AppColors.lightPrimary,
            ),
          ),
          backgroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.grey.withAlpha(50)
                  : AppColors.lightTextcolor,
        ),
        buttonName: 'Add To Cart',
        onPressed: () {
          print("${services.id}");
          viewServiceController.addToCart(services);
        },
      ),
    ],
  );
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}

Widget productDetails(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Product Highlights",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 10),
      _buildDetailRow("Concern", "No Concern"),
      _buildDetailRow("Type", "Cream"),
      const SizedBox(height: 20),
      Text(
        "Additional Details",
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 10),
      _buildDetailRow("Add On", "No Add on"),
      _buildDetailRow("Color", "15 Fair"),
      _buildDetailRow("Flavour", "No Flavour"),
      _buildDetailRow("Net Quantity (N)", "1"),
      _buildDetailRow("Shade", "Natural"),
      _buildDetailRow("Shelf life (Best Before)", "24 Months"),
      _buildDetailRow("Country of Origin", "India"),
    ],
  );
}

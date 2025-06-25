import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/favourite_controller.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/add_to_cart_card_widget.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_controller.dart';

class WishListPage extends StatelessWidget {
  WishListPage({super.key});
  final favouriteController = Get.find<FavouriteController>();
  final viewServiceController = Get.find<SubCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWidget(appBarName: "Wishlist"),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        final favItems = viewServiceController.whishList;

        if (favItems.isEmpty) {
          return const Center(
            child: Text(
              "No items in your wishlist.",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 15),
            itemCount: favItems.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 315,
            ),
            itemBuilder: (context, index) {
              final service = favItems[index];
              return AddtoCartCardWidget(
                fromWishList: true, // 👈 new
                services: service,
                // price: service.price,
                // catogryName: service.serviceName,
                // imageUrl: service.image,
                // description: service.description,
              );
            },
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_controller.dart';

import '../../utils/common_widgets/card_widgets/add_to_cart_card_widget.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewServiceController = Get.find<SubCategoryController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Shopping Cart")),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        if (viewServiceController.cardList.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }
        return Padding(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            padding: const EdgeInsets.only(bottom: 15),
            itemCount: viewServiceController.cardList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 315,
            ),
            itemBuilder: (context, index) {
              final service = viewServiceController.cardList[index];
              return AddtoCartCardWidget(
                fromCart: true,
                remove: () => viewServiceController.cardList.removeAt(index),
                showFavoriteIcon: false,
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

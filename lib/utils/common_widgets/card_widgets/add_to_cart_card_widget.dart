import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/api_urls/api_url.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/res/routes/routes_name.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_icon_button_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/bottom_sheet_card_widget.dart';
import 'package:the_aura/view_models/sub_category_service/sub_category_controller.dart';
import '../../../view_models/category/category_controller.dart';
import '../../../view_models/sub_category_service/sub_category_model.dart';

class AddtoCartCardWidget extends StatelessWidget {
  final Data? services;
  final VoidCallback? addButton;
  final IconData? icon;
  final Color? buttonColor;
  final bool fromWishList;
  final bool fromCart;
  final bool? showFavoriteIcon;
  final VoidCallback? remove;

  const AddtoCartCardWidget({
    super.key,
    this.icon,
    this.addButton,
    this.buttonColor,
    this.services,
    this.fromWishList = false,
    this.fromCart = false,
    this.showFavoriteIcon,
    this.remove,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    final viewServiceController = Get.find<SubCategoryController>();

    final screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.38; // Reduced width
    final double cardHeight = cardWidth * 1.4; // Adjusted height

    final String imageUrl =
        services?.image != null
            ? "${ApiUrl.baseUrl}${services!.image!.startsWith("/") ? "" : "/"}${services!.image}"
            : "https://demofree.sirv.com/nope-not-here.jpg";

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.white,
        border: Border.all(color: AppColors.grey.withAlpha(100)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: cardHeight * 0.65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: InkWell(
                  onTap: () {
                    final isShop =
                        categoryController.selectedCategoryName.value.trim() ==
                        "Shop";

                    if (isShop) {
                      Get.toNamed(
                        RoutesName.viewProductPage,
                        arguments: services,
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return BottomSheetCardWidget(
                            serviceName: services?.name ?? 'No Name',
                            price: services?.name.toString() ?? '0',
                            imageUrl: imageUrl,
                            description: services?.name ?? '',
                          );
                        },
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => const Center(
                            child: Icon(Icons.broken_image, size: 30),
                          ),
                    ),
                  ),
                ),
              ),
              if (fromWishList)
                MyIconButtonWidget(
                  icon: const Icon(
                    Icons.favorite_rounded,
                    color: AppColors.lightPrimary,
                  ),
                  onPressed: () {
                    if (services != null) {
                      viewServiceController.toggleFavourite(services!);
                    }
                  },
                )
              else if (fromCart)
                MyIconButtonWidget(
                  icon: const Icon(
                    Icons.remove_circle_rounded,
                    color: AppColors.lightPrimary,
                  ),
                  onPressed: remove!,
                )
              else if (showFavoriteIcon ?? true)
                Obx(() {
                  final isFavourite = viewServiceController.whishList.any(
                    (element) => element.id == services?.id,
                  );
                  return MyIconButtonWidget(
                    icon: Icon(
                      isFavourite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: AppColors.lightPrimary,
                    ),
                    onPressed: () {
                      if (services != null) {
                        viewServiceController.toggleFavourite(services!);
                      }
                    },
                  );
                }),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  services?.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14, // Reduced font
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (services?.name != null)
                  Text(
                    "\u20B9 ${services!.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14, // Reduced font
                      color: AppColors.lightPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (fromWishList)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [buyNowButton()],
                  )
                else if (icon != null)
                  Row(
                    mainAxisAlignment:
                        categoryController.selectedCategoryName.value.trim() ==
                                'Shop'
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.end,
                    children: [
                      categoryController.selectedCategoryName.value.trim() ==
                              'Shop'
                          ? buyNowButton()
                          : SizedBox(
                            height: 36, // Smaller button
                            width: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: addButton,
                              child: Icon(
                                icon,
                                size: 18, // Smaller icon
                                color: AppColors.lightTextcolor,
                              ),
                            ),
                          ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buyNowButton() {
    return SizedBox(
      width: 90,
      height: 45,
      child: MyElevatedButtonWidget(
        buttonName: "Buy Now",
        onPressed: () {
          // Handle Buy Now
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/buttons/my_elevated_button_widget.dart';
import 'package:the_aura/utils/common_utils/buttons/my_icon_button_widget.dart';
import 'package:the_aura/view_models/packages/packages_model.dart';
import '../../../controller/counter_button_controller.dart';

class CounterButtonWidget extends StatelessWidget {
  final PackageData? packageData;

  CounterButtonWidget({super.key, this.packageData});

  final counterController = Get.find<CounterButtonController>();

  @override
  Widget build(BuildContext context) {
    final counter = counterController.getCounter(packageData!.id.toString());

    return Obx(() {
      return counter.value == 0
          ? _addButton(
            context,
            () => counterController.increment(packageData!.id.toString()),
          )
          : Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? AppColors.grey.withAlpha(80)
                        : AppColors.lightPrimary,
              ),
              borderRadius: BorderRadius.circular(7),
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColors.lightText
                      : AppColors.lightTextcolor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyIconButtonWidget(
                  icon: const Icon(
                    Icons.remove,
                    color: AppColors.lightPrimary,
                    size: 20,
                  ),
                  onPressed: () {
                    counterController.decrement(packageData!.id.toString());
                  },
                ),
                SizedBox(
                  width: 27,
                  child: Center(
                    child: Text(
                      '${counter.value}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.lightPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                MyIconButtonWidget(
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.lightPrimary,
                    size: 20,
                  ),
                  onPressed: () {
                    counterController.increment(packageData!.id.toString());
                  },
                ),
              ],
            ),
          );
    });
  }

  Widget _addButton(BuildContext context, VoidCallback onPressed) {
    return SizedBox(
      width: 90,
      height: 40,
      child: MyElevatedButtonWidget(
        textStyle: const TextStyle(color: AppColors.lightPrimary),
        buttonStyle: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? AppColors.grey.withAlpha(80)
                      : AppColors.lightPrimary,
            ),
          ),
          backgroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppColors.lightText
                  : AppColors.lightTextcolor,
        ),
        buttonName: "Add",
        onPressed: onPressed,
      ),
    );
  }
}

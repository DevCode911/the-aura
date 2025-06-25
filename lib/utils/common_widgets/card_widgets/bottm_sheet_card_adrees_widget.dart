import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';

import '../../../controller/edit_profile_controller.dart';
import '../../common_utils/buttons/my_elevated_button_widget.dart';
import '../list_tile_widgets/list_tile_widgets.dart';

class BottmSheetCardAdreesWidget extends StatelessWidget {
  BottmSheetCardAdreesWidget({super.key});
  final editProfileController = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Select Address",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          ListTileWidgets(title: "Add Address", icon: Icons.add, onTap: () {}),

          const SizedBox(height: 20),
          ListTileWidgets(
            mobileNo: editProfileController.phone.value,
            tileColor: AppColors.grey.withAlpha(50),
            title: "Home",
            subtitle: "Plot no.209, Kavuri Hills, Madhapur, Telangana 500033",
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  print('Edit tapped');
                } else if (value == 'delete') {
                  print('Delete tapped');
                }
              },
              itemBuilder:
                  (context) => const [
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
              icon: const Icon(Icons.more_vert, color: AppColors.lightPrimary),
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: MyElevatedButtonWidget(
              buttonName: "Proceed",
              buttonStyle: ElevatedButton.styleFrom(
                elevation: 0,
                textStyle: Theme.of(context).textTheme.headlineSmall,
              ),
              onPressed: () {
                // Perform action (e.g., navigate or confirm address)
              },
            ),
          ),
        ],
      ),
    );
  }
}

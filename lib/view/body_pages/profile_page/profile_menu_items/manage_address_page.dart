import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/edit_profile_controller.dart';
import 'package:the_aura/res/app_theme/app_colors.dart';
import 'package:the_aura/utils/common_utils/app_bar/my_app_bar_widget.dart';
import 'package:the_aura/utils/common_widgets/list_tile_widgets/list_tile_widgets.dart';

class ManageAddressPage extends StatelessWidget {
  ManageAddressPage({super.key});

  final editProfileController = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWidget(appBarName: "Manage Address"),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          ListTileWidgets(
            title: "Add Address",
            icon: Icons.add,
            onTap: () {
              print("google map");
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTileWidgets(
                  mobileNo: editProfileController.phone.value,
                  tileColor: AppColors.grey.withAlpha(50),
                  title: "Home",
                  subtitle:
                      "Plot no.209, Kavuri Hills, Madhapur, Telangana 500033",
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
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.lightPrimary,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

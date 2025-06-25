import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_aura/controller/bottom_navi_controller.dart';

class BodyPage extends StatelessWidget {
  BodyPage({super.key});
  final bottomNaviController = Get.find<BottomNaviController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(
        () => IndexedStack(
          index: bottomNaviController.selectIndex.value,
          children: bottomNaviController.pages,
        ),
      ),

      bottomNavigationBar: Obx(
        () => Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: bottomNaviController.selectIndex.value,
            onTap: (index) {
              FocusManager.instance.primaryFocus!.unfocus();
              bottomNaviController.changeIndex(index);
            },

            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                activeIcon: Icon(Icons.grid_view_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.stars_outlined),
                activeIcon: Icon(Icons.stars_outlined),
                label: "Packages",  
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note_sharp),
                activeIcon: Icon(Icons.event_note_sharp),
                label: "Bookings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person_2_outlined),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

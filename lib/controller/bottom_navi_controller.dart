import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_aura/view/body_pages/booking_page/booking_page.dart';
import 'package:the_aura/view/body_pages/home_page/home_page.dart';
import 'package:the_aura/view/body_pages/packages_page/packages_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_page.dart';

class BottomNaviController extends GetxController {
  var selectIndex = 0.obs;
  final List<Widget> pages = [
    HomePage(),
    PackagesPage(),
    BookingPage(),
    ProfilePage(),
  ];

  void changeIndex(int index) {
    selectIndex.value = index;
  }
}

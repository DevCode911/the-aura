import 'package:get/route_manager.dart';
import 'package:the_aura/bindings/add_cart_binding.dart';
import 'package:the_aura/bindings/add_service_binding.dart';
import 'package:the_aura/bindings/api_bindings/addvertisment_binding.dart';
import 'package:the_aura/bindings/api_bindings/category_binding.dart';
import 'package:the_aura/bindings/api_bindings/packages_binding.dart';
import 'package:the_aura/bindings/api_bindings/service_binding.dart';
import 'package:the_aura/bindings/api_bindings/view_service_binding.dart';
import 'package:the_aura/bindings/bottom_navi_binding.dart';
import 'package:the_aura/bindings/counter_binding.dart';
import 'package:the_aura/bindings/edit_profile_binding.dart';
import 'package:the_aura/bindings/favourite_binding.dart';
import 'package:the_aura/bindings/image_picker_binding.dart';
import 'package:the_aura/bindings/male_service_binding.dart';
import 'package:the_aura/bindings/onboarding_binding.dart';
import 'package:the_aura/bindings/view_product_binding.dart';
import 'package:the_aura/res/routes/routes_name.dart';
import 'package:the_aura/splash_screen/splash_screen.dart';
import 'package:the_aura/utils/common_utils/buttons/counter_button_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/category_card_widget.dart';
import 'package:the_aura/utils/common_widgets/card_widgets/add_to_cart_card_widget.dart';
import 'package:the_aura/view/add_to_cart_pages/add_to_cart_page.dart';
import 'package:the_aura/view/body_pages/body_page/body_page.dart';
import 'package:the_aura/view/body_pages/home_page/home_page.dart';

import 'package:the_aura/view/body_pages/packages_page/packages_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_menu_items/about_services_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_menu_items/about_us_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_menu_items/edit_profile_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_menu_items/manage_address_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_menu_items/rate_us_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_menu_items/refer_earn_page.dart';
import 'package:the_aura/view/body_pages/profile_page/profile_page.dart';
import 'package:the_aura/view/booking_summary_pages/view_summary_page.dart';
import 'package:the_aura/view/login_screen_pages/login_page.dart';
import 'package:the_aura/view/login_screen_pages/sign_up_page.dart';
import 'package:the_aura/view/onboarding_screen_pages/on_boarding_screen_one_page.dart';
import 'package:the_aura/view/login_screen_pages/mobile_number_page.dart';
import 'package:the_aura/view/product_pages/view_product_page.dart';
import 'package:the_aura/view/selected_summary_pages/summary_page.dart';
import 'package:the_aura/view/sub_category_pages/sub_category_page.dart';
import 'package:the_aura/view/services_page/services_page.dart';
import 'package:the_aura/view/wish_list_pages/wish_list_page.dart';

class Routes {
  static const String intialRoute = RoutesName.loginPage;
  static final routes = [
    // in this bottomNavigation bar Pages (Home, Packages, Bookings, Profile)....................For only Navigation
    GetPage(
      name: RoutesName.bodyPage,
      page: () => BodyPage(),
      transition: Transition.topLevel, // or any transition
      transitionDuration: Duration(seconds: 2),
      bindings: [
        BottomNaviBinding(),
        ImagePickerBinding(),
        EditProfileBinding(),
        FavouriteBinding(),
        MaleServiceBinding(),
        CounterBinding(),
        CategoryBinding(),
        ViewServiceBinding(),
        ServiceBinding(),
        PackagesBinding(),
        AddvertismentBinding(),
      ],
    ),

    GetPage(name: RoutesName.splashScreen, page: () => SplashScreen()),

    // starting screens
    GetPage(
      name: RoutesName.onBoardingScreenOne,
      page: () => OnBoardingScreenOnePage(),
      binding: OnboardingBinding(),
    ),

    // mobile number validate page
    GetPage(name: RoutesName.mobileNumberPage, page: () => MobileNumberPage()),

    // auth pages
    GetPage(
      name: RoutesName.signUpPage,
      page: () => SignUpPage(),
      binding: BottomNaviBinding(),
    ),
    GetPage(
      name: RoutesName.loginPage,
      page: () => LoginSignUpPage(),
      binding: BottomNaviBinding(),
    ),

    // All bottom navigation pages..............................

    // home page
    GetPage(
      name: RoutesName.homePage,
      page: () => HomePage(),
      bindings: [
        CategoryBinding(),
        FavouriteBinding(),
        ViewServiceBinding(),
        ServiceBinding(),
        AddvertismentBinding(),
      ],
    ),

    // view product page
    GetPage(
      name: RoutesName.viewProductPage,
      page: () => ViewProductPage(),
      bindings: [ViewProductBinding(), ViewServiceBinding()],
    ),

    // wishList Page in Home Page
    GetPage(name: RoutesName.wishListPage, page: () => WishListPage()),

    // packages page
    GetPage(
      name: RoutesName.packagesPage,
      page: () => PackagesPage(),
      bindings: [MaleServiceBinding(), CounterBinding(), PackagesBinding()],
    ),

    // category service pages
    GetPage(
      name: RoutesName.subcategoryservicesPage,
      page: () => SubCategoryPage(),
      bindings: [
        MaleServiceBinding(),
        AddServiceBinding(),
        FavouriteBinding(),
        ViewServiceBinding(),
        PackagesBinding(),
      ],
    ),

    // all services page
    GetPage(
      name: RoutesName.servicesPage,
      page: () => ServicesPage(),
      bindings: [
        ServiceBinding(),
        MaleServiceBinding(),
        AddServiceBinding(),
        FavouriteBinding(),
        ViewServiceBinding(),
      ],
    ),

    // add to cart page
    GetPage(
      name: RoutesName.addToCartPage,
      page: () => AddToCartPage(),
      bindings: [AddCartBinding(), ViewServiceBinding()],
    ),

    // summary page
    GetPage(
      name: RoutesName.summaryPage,
      page: () => SummaryPage(),
      binding: ViewServiceBinding(),
    ),

    // view summary page
    GetPage(name: RoutesName.viewSummaryPage, page: () => ViewSummaryPage()),

    // profile pages
    GetPage(
      name: RoutesName.profilePage,
      page: () => ProfilePage(),
      bindings: [ImagePickerBinding(), EditProfileBinding()],
    ),

    GetPage(
      name: RoutesName.editProfilePage,
      page: () => EditProfilePage(),
      bindings: [ImagePickerBinding(), EditProfileBinding()],
    ),

    GetPage(
      name: RoutesName.manageAdressPage,
      page: () => ManageAddressPage(),
      binding: EditProfileBinding(),
    ),
    GetPage(name: RoutesName.raferEarnPage, page: () => ReferEarnPage()),
    GetPage(name: RoutesName.rateUsPage, page: () => RateUsPage()),
    GetPage(name: RoutesName.aboutUsPage, page: () => AboutUsPage()),

    GetPage(
      name: RoutesName.aboutServicesPage,
      page: () => AboutServicesPage(),
    ),

    // widgets page
    GetPage(
      name: RoutesName.serviceCardWidget,
      page: () => AddtoCartCardWidget(),
      bindings: [CategoryBinding(), ViewServiceBinding()],
    ),
    GetPage(
      name: RoutesName.categoryCardWidget,
      page: () => CategoryCardWidget(),
      bindings: [FavouriteBinding(), CategoryBinding()],
    ),
    GetPage(
      name: RoutesName.counterController,
      page: () => CounterButtonWidget(packageData: Get.arguments ?? "unknown"),
      binding: CounterBinding(),
    ),
    GetPage(
      name: RoutesName.wishListPage,
      page: () => WishListPage(),
      bindings: [FavouriteBinding(), ViewServiceBinding()],
    ),
  ];
}

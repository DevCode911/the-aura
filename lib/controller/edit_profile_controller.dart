// controller/profile_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var name = FirebaseAuth.instance.currentUser!.displayName.obs;
  var email = FirebaseAuth.instance.currentUser!.email.obs;
  var phone = '7016394629'.obs;

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newPhone,
  }) {
    name.value = newName;
    email.value = newEmail;
    phone.value = newPhone;
  }
}

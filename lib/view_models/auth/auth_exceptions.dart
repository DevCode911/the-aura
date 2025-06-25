import 'package:get/get.dart';

class AuthExceptions {
  static void handle(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        Get.snackbar(
          "Login Failed",
          "Account exists with different credentials.",
        );
        break;

      case 'invalid-credential':
        Get.snackbar("Already Signed In", "You are already logged in.");
        break;

      case 'operation-not-allowed':
        Get.snackbar(
          "Login Failed",
          "Operation not allowed. Enable in Firebase Console.",
        );
        break;

      case 'user-disabled':
        Get.snackbar("Login Failed", "This user has been disabled.");
        break;

      case 'user-not-found':
        Get.snackbar("Login Failed", "No user found for this email.");
        break;

      case 'wrong-password':
        Get.snackbar("Login Failed", "Incorrect password.");
        break;

      case 'invalid-verification-code':
        Get.snackbar("Login Failed", "Invalid verification code.");
        break;

      case 'invalid-verification-id':
        Get.snackbar("Login Failed", "Invalid verification ID.");
        break;

      case 'network-request-failed':
        Get.snackbar("Network Error", "Please check your internet connection.");
        break;

      case 'sign_in_canceled':
        Get.snackbar("Login Cancelled", "Google sign-in was cancelled.");
        break;

      default:
        Get.snackbar("Error", "An unexpected error occurred: $code");
    }
  }
}

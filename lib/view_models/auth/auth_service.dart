// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   // google sign in
//   signInWithGoogle() async {
//     // begin signIn proccess
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     await googleSignIn.signOut();
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     final GoogleSignInAuthentication gAuth = await gUser!.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );
//     return await _firebaseAuth.signInWithCredential(credential);
//   }

//   signOut() async {
//     await GoogleSignIn().signOut(); // Google SignOut
//     await _firebaseAuth.signOut(); // Firebase SignOut
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_aura/view_models/auth/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      AuthExceptions.handle(e.code);
    } on PlatformException catch (e) {
      AuthExceptions.handle(e.code);
    } catch (e) {
      AuthExceptions.handle(e.toString());
    }
  }

  signOut() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }
}

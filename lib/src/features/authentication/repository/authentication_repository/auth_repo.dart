import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/features/authentication/screens/sign_up_screen/signup_screen.dart';
import 'package:vivid/src/routing/main_screen/screens/main_screen/main_screen.dart';
import '../../../profile/repository/user_repo.dart';
import '../../controllers/sign_in_controller.dart';
import 'exceptions/signupwith_emailpassword_failure.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final userRepo = Get.put(UserRepo());

  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => SignupScreen());
    } else {
      Get.offAll(() => mainScreen(key: GlobalKey(), initialPage: 2));
    }
  }

  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure(e.code);
      print('Firebase Auth exception ${ex.message}');
      throw ex;
    } catch (_) {
      // Handle other exceptions
      return null;
    }
  }


  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later';
          break;
      }
      SignInController.instance.errorMessage.value = errorMessage;
    } catch (error) {
      SignInController.instance.errorMessage.value = 'An error occurred. Please try again later';
    }
  }


  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print("Error logging out: $error");
    }
  }
}

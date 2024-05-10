import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../repository/authentication_repository/auth_repo.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = false.obs;
  final showPassword = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<String> errorMessage = Rx<String>('');

  void toggleRememberMe() {
    rememberMe.toggle();
  }

  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  void signInUser() async {
    if (formKey.currentState!.validate()) {
      try {
        await AuthRepo.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      } catch (error) {
        String errorText = 'An error occurred. Please try again later.';
        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'user-not-found':
              errorText = 'No user found with this email.';
              break;
            case 'wrong-password':
              errorText = 'Wrong password.';
              break;
          }
        }
        errorMessage.value = errorText;
      }
    }
  }
}

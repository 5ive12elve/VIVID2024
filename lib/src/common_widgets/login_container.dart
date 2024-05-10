import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import 'package:vivid/src/features/authentication/controllers/sign_in_controller.dart';

import '../features/authentication/controllers/sign_up_screen_controller.dart';
import '../features/profile/screens/profile_screen.dart';

class LoginContainer extends StatelessWidget {
  final controller = Get.find<SignInController>(); // Use Get.find instead of Get.put
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.35),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: vivid_colors.ttPrimaryColor,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Hello there, sign in to continue!',
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: vivid_colors.ttPrimaryColor,
                ),
              ),
              const SizedBox(height: 20),
              BuildLoginField(
                label: 'Email',
                icon: Icons.email,
                controller: SignInController.instance.email,
              ),
              const SizedBox(height: 20),
              BuildLoginField(
                label: 'Password',
                icon: Icons.lock,
                controller: SignInController.instance.password,
                isPassword: true,
              ),
              const SizedBox(height: 50),
              buildSignInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    SignInController signInController = Get.find<SignInController>(); // Change here

    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            signInController.signInUser(
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: const Text(
          'Sign in',
          style: TextStyle(
            fontFamily: 'LexendDeca',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: vivid_colors.ttSecondaryColor,
          ),
        ),
      ),
    );
  }

}

class BuildLoginField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;

  const BuildLoginField({
    required this.label,
    required this.icon,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontFamily: 'LexendDeca',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: vivid_colors.ttPrimaryColor,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: vivid_colors.ttPrimaryColor,
                width: 2.0,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: vivid_colors.ttPrimaryColor,
                width: 1.0,
              ),
            ),
            suffixIcon: Icon(
              icon,
              size: 20,
              color: vivid_colors.ttPrimaryColor,
            ),
          ),
          obscureText: isPassword,
          validator: (value) {
            if (isPassword) {
              // Add password validation logic if needed
            }
            return null;
          },
        ),
      ),
    );
  }
}

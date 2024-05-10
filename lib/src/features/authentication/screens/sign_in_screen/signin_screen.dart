import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import 'package:vivid/src/constants/images.dart';
import 'package:vivid/src/features/authentication/controllers/sign_in_controller.dart';

import '../sign_up_screen/signup_screen.dart';

class SigninScreen extends StatelessWidget {
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vivid_colors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 37, 26, 10),
          child: GetBuilder<SignInController>(
            builder: (controller) => Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: vivid_colors.primaryTextColor,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(vivid_images.vividLogo),
                          height: 60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: vivid_colors.primaryTextColor,
                        fontSize: 28,
                        fontFamily: "SF PRO",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildEmail(),
                  const SizedBox(height: 16),
                  _buildPassword(),
                  const SizedBox(height: 9),
                  _buildErrorMessage(),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      _buildRememberMeCheckbox(),
                      const Text(
                        "Remember me",
                        style: TextStyle(
                          color: vivid_colors.primaryTextColor,
                          fontSize: 14,
                          fontFamily: "SF PRO",
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.14,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle "Forgot Password?" press
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: vivid_colors.secondaryTextColor,
                                fontSize: 14,
                                fontFamily: "SF PRO",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 39),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: vivid_colors.primaryTextColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: vivid_colors.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLoginButton(context),
                  const SizedBox(height: 20),
                  _buildOrSignWithGoogle(),
                  const SizedBox(height: 20),
                  _buildGoogle(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: SignInController.instance.email,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(
          Icons.person_2_outlined,
          color: vivid_colors.secondaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: vivid_colors.secondaryColor,
            width: 1,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: "SF PRO",
          fontWeight: FontWeight.w400,
          color: vivid_colors.secondaryColor,
          letterSpacing: 0.3,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPassword() {
    return Obx(() {
      bool obscureText = !SignInController.instance.showPassword.value;

      return TextFormField(
        controller: SignInController.instance.password,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(
            Icons.lock_outlined,
            color: vivid_colors.secondaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: vivid_colors.secondaryColor,
            ),
            onPressed: () {
              SignInController.instance.togglePasswordVisibility();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: vivid_colors.secondaryColor,
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontFamily: "SF PRO",
            fontWeight: FontWeight.w400,
            color: vivid_colors.secondaryColor,
            letterSpacing: 0.3,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        },
      );
    });
  }

  Widget _buildRememberMeCheckbox() {
    return Obx(() {
      bool rememberMe = SignInController.instance.rememberMe.value;

      return Checkbox(
        value: rememberMe,
        onChanged: (value) {
          SignInController.instance.toggleRememberMe();
        },
      );
    });
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          controller.signInUser();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: vivid_colors.buttonsPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          padding: const EdgeInsets.all(14),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Login",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "SF PRO",
                fontWeight: FontWeight.w400,
                color: vivid_colors.buttonsTextColor,
                letterSpacing: 0.16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrSignWithGoogle() {
    return const SizedBox(
      width: 166,
      height: 17,
      child: Text(
        "Or Sign in With Google",
        style: TextStyle(
          fontSize: 14,
          fontFamily: "SF PRO",
          fontWeight: FontWeight.w400,
          color: vivid_colors.secondaryColor,
          letterSpacing: 0.14,
        ),
      ),
    );
  }

  Widget _buildGoogle() {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Handle Google button press
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: vivid_colors.buttonsPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
            side: const BorderSide(
              color: vivid_colors.secondaryColor,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: Image.asset(
                  'assets/images/google.png',
                  width: 16,
                  height: 16,
                  fit: BoxFit.none,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Google",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "SF PRO",
                  fontWeight: FontWeight.w400,
                  color: vivid_colors.buttonsTextColor,
                  letterSpacing: 0.14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Obx(() {
      final errorMessage = SignInController.instance.errorMessage.value;

      if (errorMessage.isEmpty) {
        return SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          errorMessage,
          style: TextStyle(
            color: Colors.red, // Choose your desired color for error messages
            fontSize: 14,
          ),
        ),
      );
    });
  }
}

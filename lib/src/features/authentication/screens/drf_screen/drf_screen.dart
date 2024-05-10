import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/drf_screen_controller.dart';
import '../sign_up_screen/signup_screen.dart';
import 'package:vivid/src/constants/colors.dart';

class DrfScreen extends StatelessWidget {
  final String username;
  final String email;
  final String phoneNumber;
  final String governorate;
  final String profession;
  final String password;

  const DrfScreen({
    Key? key,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.governorate,
    required this.profession,
    required this.password,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrfScreenController>(
      init: DrfScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: vivid_colors.primaryColor,
        appBar: AppBar(
          backgroundColor: vivid_colors.primaryColor,
          elevation: 0,
          title: Text(
            '$profession Attributes',
            style: TextStyle(
              color: vivid_colors.secondaryTextColor,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: vivid_colors.secondaryTextColor),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 0, 26, 10),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var entry in controller.professionAttributes[controller.professionsId[profession]!].entries)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        controller: controller.createTextController(entry.key),//controller.textEditingController[entry.key],
                        decoration: InputDecoration(
                          labelText: entry.key,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: vivid_colors.primaryTextColor,
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
                        onChanged: (value) {
                          controller.updateAttribute(entry.key, value);
                        },
                      ),
                    ),
                  SizedBox(height: 10),
                  _buildCreateAccountButton(context, controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context, DrfScreenController controller) {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            controller.registerUser(
              email: email.trim(),
              password: password.trim(),
              profilePictureUrl: "https://t3.ftcdn.net/jpg/03/64/62/36/360_F_364623623_ERzQYfO4HHHyawYkJ16tREsizLyvcaeg.jpg",
              username: username.trim(),
              phoneNumber: phoneNumber.trim(),
              governorate: governorate.trim(),
              profession: profession.trim(),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: vivid_colors.buttonsPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          padding: const EdgeInsets.all(14),
        ),
        child: const Text(
          "Create account",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "SF PRO",
            fontWeight: FontWeight.w400,
            color: vivid_colors.buttonsTextColor,
            letterSpacing: 0.16,
          ),
        ),
      ),
    );
  }
}

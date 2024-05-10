import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vivid/src/features/authentication/models/users_model.dart';

import '../repository/authentication_repository/auth_repo.dart';
import '../../profile/repository/user_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final RxBool obscureText = true.obs;

  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phone_number = TextEditingController();
  final TextEditingController governorate = TextEditingController();
  final TextEditingController profession = TextEditingController();
  final UserRepo userRepo = Get.put(UserRepo());

  final String defaultGovernorate = 'Cairo';
  final String defaultProfession = 'Engineer';
  final String defaultAbout = 'No information available';

  // Define the selectedGovernorate property
  final RxString selectedGovernorate = 'Alexandria'.obs;
  RxString selectedProfession = 'Actor'.obs;

  late Map<String, String> proAtts = {};

  // Method to set the profession attributes
  void setProAtts(Map<String, String> attributes) {
    proAtts = attributes;
  }

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  Future<void> registerUser(String email, String password, String profilePictureUrl) async {
    try {
      print('Registering user...');

      // Print all data before registration
      print('Email: $email');
      print('Fullname: ${fullname.text.trim()}');
      print('Phone number: ${phone_number.text.trim()}');
      print('Selected governorate: ${selectedGovernorate.value}');
      print('Selected profession: ${profession.text.trim()}');
      print('Profession attributes: $proAtts');

      setProAtts(proAtts);
      String? userId = await AuthRepo.instance.createUserWithEmailAndPassword(email, password);
      if (userId != null) {
        // Use the selectedGovernorate value from the controller
        String selectedGovernorateValue = selectedGovernorate.value.trim().isEmpty ? defaultGovernorate : selectedGovernorate.value.trim();
        String selectedProfession = profession.text.trim().isEmpty ? defaultProfession : profession.text.trim();

        UserModel user = UserModel(
          id: userId,
          email: email,
          fullname: fullname.text.trim(),
          phoneNo: phone_number.text.trim(),
          governorate: selectedGovernorateValue,
          profession: selectedProfession,
          about: defaultAbout,
          profilePictureUrl: profilePictureUrl,
          professionAttributes: proAtts,
        );

        // Print user data before sending to Firestore
        print('User data to be saved: $user');

        await userRepo.createUser(user);
        print('User registered successfully!');
      }
    } catch (e) {
      print('Error registering user: $e');
      // Handle registration error
    }
  }
}

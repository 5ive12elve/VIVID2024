import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import 'package:vivid/src/constants/images.dart';
import 'package:vivid/src/constants/strings.dart';
import 'package:vivid/src/features/authentication/controllers/sign_up_screen_controller.dart';
import 'package:vivid/src/features/authentication/screens/sign_in_screen/signin_screen.dart';

import '../drf_screen/drf_screen.dart';

class SignupScreen extends StatelessWidget {
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vivid_colors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 37, 26, 10),
          child: Form(
            key: _formKey,
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
                        // Handle back arrow press
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
                    "Create Account",
                    style: TextStyle(
                      color: vivid_colors.primaryTextColor,
                      fontSize: 28,
                      fontFamily: "SF PRO",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 286,
                    margin: const EdgeInsets.only(right: 40),
                    child: const Text(
                      "Create an account to find your dream job",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: vivid_colors.primaryTextColor,
                        fontSize: 16,
                        height: 1.30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 21),
                _buildUserName(),
                const SizedBox(height: 16),
                _buildEmail(),
                const SizedBox(height: 16),
                _buildNumber(),
                const SizedBox(height: 16),
                _buildGovernorate(),
                const SizedBox(height: 16),
                _buildProfession(context), // Pass context here
                const SizedBox(height: 16),
                _buildPassword(),
                const SizedBox(height: 9),
                const SizedBox(height: 18),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: vivid_colors.primaryTextColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SigninScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: vivid_colors.secondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildNextButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return TextFormField(
      controller: SignUpController.instance.fullname,
      decoration: InputDecoration(
        labelText: 'Username',
        prefixIcon: const Icon(
          Icons.person_2_outlined,
          color: vivid_colors.secondaryColor,
        ),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      controller: SignUpController.instance.email,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(
          Icons.email_outlined,
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
          return 'Please enter your email address';
        }
        if (!GetUtils.isEmail(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildNumber() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: SignUpController.instance.phone_number,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: const Icon(
          Icons.phone_outlined,
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
          return 'Please enter your phone number';
        }
        return null;
      },
    );
  }

  Widget _buildGovernorate() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Governorate',
        prefixIcon: const Icon(
          Icons.location_on_outlined,
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
          color: vivid_colors.secondaryColor, // Use the same color as other elements
          letterSpacing: 0.3,
        ),
      ),
      value: SignUpController.instance.selectedGovernorate.value,
      onChanged: (String? newValue) {
        SignUpController.instance.selectedGovernorate.value = newValue ?? '';
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your governorate';
        }
        return null;
      },
      items: vivid_strings.egyGovs.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              color: vivid_colors.secondaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProfession(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Profession',
        prefixIcon: const Icon(
          Icons.work_sharp,
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
      value: SignUpController.instance.selectedProfession.value,
      onChanged: (String? newValue) {
        SignUpController.instance.selectedProfession.value = newValue ?? '';
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your profession';
        }
        return null;
      },
      items: _buildProfessionItems(),
    );
  }

  List<DropdownMenuItem<String>> _buildProfessionItems() {
    List<String> professions = [
      "1st AD (Assistant Director)",
      "2nd AC (Assistant Camera)",
      "Actor",
      "ADR (Automated Dialogue Replacement) Mixer",
      "Art Director",
      "Armorer",
      "Assistant Costume Designer",
      "Assistant Editor",
      "Assistant Makeup Artist",
      "Assistant Production Accountant",
      "Assistant Production Coordinator",
      "Assistant Prop Master",
      "Associate Producer",
      "Boom Operator",
      "Camera Operator",
      "Casting Assistant",
      "Casting Associate",
      "Casting Director",
      "Choreographer",
      "Cinematographer",
      "Co-producer",
      "Colorist",
      "Company Producer",
      "Composer",
      "Costume Designer",
      "Digital Imaging Technician",
      "Director",
      "Director of Photography",
      "Dolly Grip",
      "Drone Operator and Drone Pilot",
      "Entertainment Lawyer",
      "Extra",
      "Festival Programmer",
      "Field Recording Mixer",
      "Film Editor",
      "Film Electrician (Rigging and On-set Electrics)",
      "First AC",
      "Foley Artist and Foley Engineer",
      "Gaffer or Best Boy",
      "Graphic Artist",
      "Grip and Key Grip",
      "Hairdresser and Key Hair Stylist",
      "Key PA (Production Assistant)",
      "Line Producer or UPM (Unit Production Manager)",
      "Location Manager",
      "Location Scout",
      "Makeup Artist",
      "Manager",
      "Music Supervisor",
      "On Set VFX Supervisor or Visual Effects Supervisor",
      "Post Supervisor",
      "Post-Production Coordinator or Production Coordinator",
      "Producer or Executive Producer",
      "Production Accountant",
      "Production Designer and (Set Decorator or Set Dresser)",
      "Props Manager",
      "Re-Recording Mixer",
      "Screenwriter",
      "Script Analyst or Script Reader",
      "Script Supervisor",
      "Showrunner or TV Producer",
      "Sound Designer",
      "Storyboard Artist",
      "Stunt Coordinator"
    ];

    return professions.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(
            color: vivid_colors.secondaryColor,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildPassword() {
    return Obx(() {
      return TextFormField(
        controller: SignUpController.instance.passwordController,
        obscureText: SignUpController.instance.obscureText.value,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const Icon(
            Icons.lock_outlined,
            color: vivid_colors.secondaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              SignUpController.instance.obscureText.value ? Icons.visibility : Icons.visibility_off,
              color: vivid_colors.secondaryColor,
            ),
            onPressed: () {
              SignUpController.instance.togglePasswordVisibility();
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
          if (value.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        },
      );
    });
  }
  Widget _buildNextButton() {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if(_formKey.currentState!.validate()){
            // Retrieve all input or selected values
            String username = SignUpController.instance.fullname.text.trim();
            String email = SignUpController.instance.email.text.trim();
            String phoneNumber = SignUpController.instance.phone_number.text.trim();
            String governorate = SignUpController.instance.selectedGovernorate.value;
            String profession = SignUpController.instance.selectedProfession.value;
            String password = SignUpController.instance.passwordController.text.trim();

            // Navigate to the new screen and pass all values as arguments
            Get.offAll(DrfScreen(
              username: username,
              email: email,
              phoneNumber: phoneNumber,
              governorate: governorate,
              profession: profession,
              password: password,
              // Pass other fields as needed
            ));
          }
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
              "Next",
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

}

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:vivid/src/constants/colors.dart';
import '../features/authentication/controllers/sign_up_screen_controller.dart';
import '../features/authentication/models/users_model.dart';
import '../features/profile/screens/profile_screen.dart';



/*class ContentContainer extends StatelessWidget {
  final controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>(); // Step 2

  ContentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey, // Step 1: Add the form key
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Register',
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400,
                  color: vivid_colors.ttSecondaryColor,
                ),
              ),
              const SizedBox(height: 20),
              buildRegistrationField(
                'Full Name',
                Icons.person_rounded,
                context,
                controller: SignUpController.instance.fullname, // Pass the controller
              ),
              const SizedBox(height: 20),
              buildRegistrationField(
                'E-Mail',
                Icons.email_rounded,
                context,
                controller: SignUpController.instance.email, // Pass the controller
              ),
              const SizedBox(height: 20),
              buildRegistrationField(
                'Phone No',
                Icons.local_phone,
                context,
                controller: SignUpController.instance.phone_number, // Pass the controller
              ),
              const SizedBox(height: 20),
              buildRegistrationField(
                'Password',
                Icons.lock,
                context,
                controller: SignUpController.instance.password, // Pass the controller
                isPassword: true,
              ),
              const SizedBox(height: 20),
              buildRegistrationField(
                'Confirm Password',
                Icons.check,
                context,
                controller: SignUpController.instance.password, // Pass the controller
                isPassword: true,
              ), // Step 3
              const SizedBox(height: 40),
              buildButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRegistrationField(String label, IconData icon, BuildContext context,
      {bool isPassword = false, required TextEditingController controller}) { // Step 3
    const customTextStyle = TextStyle(
      fontFamily: 'LexendDeca',
      fontSize: 14,
      color: vivid_colors.ttSecondaryColor,
      fontWeight: FontWeight.w500,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: TextFormField( // Use TextFormField
          controller: controller, // Step 3
          style: customTextStyle,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontFamily: 'LexendDeca',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: vivid_colors.ttAccentColor,
            ),
            focusedBorder: const CustomUnderlineInputBorder(
              borderSide: BorderSide(
                color: vivid_colors.ttAccentColor,
                width: 2.0,
              ),
            ),
            enabledBorder: const CustomUnderlineInputBorder(
              borderSide: BorderSide(
                color: vivid_colors.ttAccentColor,
                width: 1.0,
              ),
            ),
            suffixIcon: Icon(
              icon,
              size: 20,
              color: vivid_colors.ttSecondaryColor,
            ),
          ),
          obscureText: isPassword,
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) { // Step 4: Validate the form
            SignUpController.instance.registerUser(
              SignUpController.instance.email.text.trim(),
              SignUpController.instance.password.text.trim(),
            );
            final user = UserModel(
              email: controller.email.text.trim(),
              password: controller.password.text.trim(),
              phoneNo: controller.phone_number.text.trim(),
              fullname: controller.fullname.text.trim()
            );
            SignUpController.instance.createUser(user);
            // Navigate to the profile screen after successful registration
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ));
          }
        },
        style: ElevatedButton.styleFrom(
          primary: vivid_colors.ttPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: const Text(
          'Create an Account',
          style: TextStyle(
            fontFamily: 'LexendDeca',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}*/
/*class CustomUnderlineInputBorder extends UnderlineInputBorder {
  final double reducedLineWidth;

  const CustomUnderlineInputBorder({
    BorderSide borderSide = const BorderSide(),
    this.reducedLineWidth = 0.7, // Adjust this value to reduce the line width
  }) : super(borderSide: borderSide);

  @override
  OutlineInputBorder createOutline(OutlineInputBorder borderSide) {
    return OutlineInputBorder(
      borderRadius: borderSide.borderRadius,
      borderSide: BorderSide(
        color: borderSide.borderSide.color,
        width: borderSide.borderSide.width - (0.4 * borderSide.borderSide.width),
      ),
    );
  }
}*/


// EditProfileScreen
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final EditProfileController _controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vivid_colors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: vivid_colors.primaryTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: vivid_colors.primaryTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF PRO',
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (!_controller.isDataFetched.value) {
          print("Waiting for user data...");
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _controller.selectProfilePicture,
                child: Column(
                  children: [
                    CircleAvatar(
                      key: UniqueKey(),
                      radius: 70,
                      backgroundImage: _controller.profileImage != null
                          ? FileImage(_controller.profileImage!)
                          : _controller.userData.value?.profilePictureUrl != null
                          ? NetworkImage(_controller.userData.value!.profilePictureUrl)
                          : AssetImage('assets/images/profile.jpg') as ImageProvider,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Change Photo',
                      style: TextStyle(
                        color: vivid_colors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              buildTextField(_controller.nameController, 'Full name', Icons.person),
              SizedBox(height: 15),
              buildTextField(_controller.roleController, 'Role', Icons.work),
              SizedBox(height: 15),
              buildTextField(_controller.governorateController, 'Governorate', Icons.location_on),
              SizedBox(height: 15),
              buildTextField(_controller.phoneController, 'Phone Number', Icons.phone),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _controller.updateUser,
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "SF PRO",
                    fontWeight: FontWeight.w400,
                    color: vivid_colors.buttonsTextColor,
                    letterSpacing: 0.16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: vivid_colors.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText, IconData prefixIcon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: vivid_colors.secondaryColor),
        prefixIcon: Icon(prefixIcon, color: vivid_colors.secondaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: vivid_colors.secondaryColor),
        ),
      ),
    );
  }
}

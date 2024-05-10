import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import 'package:vivid/src/features/profile/screens/edit_profile_screen.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
            () {
          final userData = _controller.userData.value;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(26, 37, 26, 10),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: userData?.profilePictureUrl != null
                          ? NetworkImage(userData!.profilePictureUrl!)
                          : AssetImage('assets/images/default') as ImageProvider,
                    ),
                    SizedBox(height: 20),
                    if (userData != null)
                      Column(
                        children: [
                          Text(
                            userData.fullname,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: vivid_colors.ttHeadColor,
                              fontFamily: 'SF PRO',
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            userData.profession,
                            style: TextStyle(
                              fontSize: 14,
                              color: vivid_colors.ttSubtitleColor,
                              fontFamily: 'SF PRO',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                    else
                      CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(EditProfileScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vivid_colors.ttSubtitleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(145, 33),
                            padding: const EdgeInsets.all(8.0),
                          ),
                          child: const Text(
                            'Edit profile',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: vivid_colors.ttPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            // Add your logic for the Share Profile button click here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: vivid_colors.ttSubtitleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(145, 33),
                            padding: const EdgeInsets.all(8.0),
                          ),
                          child: const Text(
                            'Share Profile',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: vivid_colors.ttPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: 327,
                      height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildInformationItem('Posts', '46'),
                          buildDivider(),
                          buildInformationItem('Followers', '23'),
                          buildDivider(),
                          buildInformationItem('Following', '16'),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 327,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 0.01,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 0.01,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          buildText(
                            'I\'m Mohamed Elesely',
                            'I\'m a Junior Android developer. I have experience working with Flutter and Dart. I am passionate about mobile app development and always eager to learn new technologies.',
                            14,
                            Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInformationItem(String label, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            letterSpacing: 0.01,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: 0.01,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      width: 1,
      height: 44,
      color: const Color(0xFFD1D5DB),
    );
  }

  Widget buildText(String label, String text, double fontSize, Color color) {
    return Container(
      width: 327,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              letterSpacing: 0.01,
              color: color,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              letterSpacing: 0.01,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

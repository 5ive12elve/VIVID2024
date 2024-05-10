import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/features/authentication/repository/authentication_repository/auth_repo.dart';
import 'package:vivid/src/features/profile/repository/user_repo.dart';
import 'package:vivid/src/features/profile/controllers/edit_profile_controller.dart';
import 'package:vivid/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:vivid/src/features/search/controllers/search_bar_controller.dart';
import 'package:vivid/src/features/chat/repository/chat_repo.dart'; // Import ChatRepository

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize all necessary dependencies
  Get.put(UserRepo());
  Get.put(SearchBarController());
  Get.put(AuthRepo());
  Get.put(ChatRepository());

  runApp(const VividApp());
}

class VividApp extends StatelessWidget {
  const VividApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditProfileController());
  }
}

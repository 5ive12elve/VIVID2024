import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../authentication/models/users_model.dart';
import '../repository/user_repo.dart';

class EditProfileController extends GetxController {
  final UserRepo _userRepo = Get.find<UserRepo>();

  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController governorateController;
  late TextEditingController phoneController;
  Rx<File?> _profileImage = Rx<File?>(null);
  Rx<UserModel?> userData = Rx<UserModel?>(null);
  RxBool isDataFetched = RxBool(false);

  StreamSubscription<UserModel?>? _userDataSubscription;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    roleController = TextEditingController();
    governorateController = TextEditingController();
    phoneController = TextEditingController();

    // Fetch user data when the controller is initialized
    fetchUserData();

    // Start listening to user data stream
    _userDataSubscription = _userRepo.userDataStream.listen((user) {
      userData.value = user;

      // Update text controllers when user data changes
      nameController.text = user?.fullname ?? '';
      roleController.text = user?.profession ?? '';
      governorateController.text = user?.governorate ?? '';
      phoneController.text = user?.phoneNo ?? '';

      // Set data fetched state to true when data is received
      isDataFetched.value = true;
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    roleController.dispose();
    governorateController.dispose();
    phoneController.dispose();

    // Cancel the subscription when the controller is closed
    _userDataSubscription?.cancel();

    super.onClose();
  }

  Future<void> fetchUserData() async {
    final email = _userRepo.getCurrentUserEmail();
    if (email != null) {
      final user = await _userRepo.getUserDetails(email);
      userData.value = user;
    }
  }

  Future<void> updateUser() async {
    try {
      final email = _userRepo.getCurrentUserEmail();
      if (email != null) {
        String? profilePictureUrl;
        if (_profileImage.value != null) {
          profilePictureUrl = await _userRepo.uploadProfilePicture(_profileImage.value!);
        } else {
          // If profile picture is not updated, use the existing URL
          profilePictureUrl = userData.value?.profilePictureUrl;
        }

        final updatedUserData = UserModel(
          email: email,
          fullname: nameController.text,
          profession: roleController.text,
          governorate: governorateController.text,
          phoneNo: phoneController.text,
          profilePictureUrl: profilePictureUrl ?? '',
          professionAttributes: {} ,
        );

        await _userRepo.updateUser(updatedUserData);
        Get.snackbar(
          "Success",
          "Your profile has been updated.",
          snackPosition: SnackPosition.BOTTOM,
        );

        // Refresh user data after update
        await fetchUserData();
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to update profile. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error updating user: $error");
    }
  }

  void selectProfilePicture() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _profileImage.value = File(pickedFile.path);

        // Update the UI immediately after selecting the image
        update();
      }
    } catch (e) {
      print('Error selecting profile picture: $e');
      // Handle error
    }
  }

  File? get profileImage => _profileImage.value;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/repository/user_repo.dart';

class ProfessionAttributesController extends GetxController {
  final UserRepo _userRepo = Get.find();
  Map<String, String> professionAttributes = {};

  void setAttributeValue(String attribute, String value) {
    professionAttributes[attribute] = value;
  }

  bool get areAttributesEmpty {
    return professionAttributes.values.any((value) => value.isEmpty);
  }

  Future<void> updateProfessionAttributes(String selectedProfessionValue) async {
    try {
      // Call the appropriate method from the user repository based on the selected profession
      switch (selectedProfessionValue) {
        case "1st AD (Assistant Director)":
          await _userRepo.updateADAttributes(professionAttributes);
          break;
        case "2nd AC (Assistant Camera)":
          await _userRepo.updateACAttributes(professionAttributes);
          break;
        case "Actor":
          await _userRepo.updateActorAttributes(professionAttributes);
          break;
        case "ADR (Automated dialouge replacement) Mixer":
          await _userRepo.updateADRAttributes(professionAttributes);
          break;
        case "Art Director":
          await _userRepo.updateArtDirectorAttributes(professionAttributes);
          break;
        default:
          print("Selected profession not supported.");
      }

      // Show success message
      Get.snackbar(
        "Success",
        "Profession attributes updated successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (error) {
      // Show error message
      Get.snackbar(
        "Error",
        "Failed to update profession attributes. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error updating profession attributes: $error");
    }
  }
}

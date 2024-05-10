import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivid/src/constants/colors.dart';

import '../../authentication/models/users_model.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _profilePictureKey = 'profile_picture_url';

  RxString currentUserEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize currentUserEmail with the current user's email
    currentUserEmail.value = FirebaseAuth.instance.currentUser?.email ?? '';
    // Listen for authentication state changes and update currentUserEmail accordingly
    FirebaseAuth.instance.authStateChanges().listen((user) {
      currentUserEmail.value = user?.email ?? '';
    });
  }

  Stream<UserModel?> get userDataStream async* {
    final email = currentUserEmail.value;
    if (email.isNotEmpty) {
      yield* _db
          .collection("Users")
          .where("Email", isEqualTo: email)
          .snapshots()
          .map((snapshot) =>
      snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).firstOrNull);
    }
  }

  Future<String?> uploadProfilePicture(File imageFile) async {
    try {
      final currentUserEmail = this.currentUserEmail.value;
      if (currentUserEmail.isNotEmpty) {
        final reference =
        _storage.ref().child('profile_pictures/$currentUserEmail.jpg');
        print('Uploading profile picture...');
        final uploadTask = reference.putFile(imageFile);

        // Listen to the upload progress
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          print('Upload progress: $progress');
        });

        // Await the completion of the upload
        final TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() {});

        // Get download URL
        final downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Save profile picture URL
        await saveProfilePictureUrl(downloadUrl);

        print('Profile picture uploaded successfully: $downloadUrl');
        return downloadUrl;
      }
    } catch (error, stackTrace) {
      print("Error uploading profile picture: $error");
      print("Stack trace: $stackTrace");
      rethrow;
    }
    return null;
  }

  Future<void> saveProfilePictureUrl(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_profilePictureKey, url);
    } catch (error) {
      print("Error saving profile picture URL: $error");
    }
  }

  Future<bool> doesUserExist(String email) async {
    try {
      final snapshot =
      await _db.collection("Users").where("Email", isEqualTo: email).get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  Future<List<UserModel>> searchUsers(String fullName, String currentUserEmail) async {
    try {
      final snapshot = await _db.collection("Users")
          .where("FullName", isGreaterThanOrEqualTo: fullName)
          .where("FullName", isLessThan: fullName + 'z')
          .get();

      // Filter out the current user by email
      final userData = snapshot.docs
          .map((doc) => UserModel.fromSnapshot(doc))
          .where((user) => user.email != currentUserEmail)
          .toList();

      return userData;
    } catch (error) {
      print("Error searching users: $error");
      return [];
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson()); // Use user ID as document ID
      Get.snackbar(
        "Success",
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: vivid_colors.ttSnackBarSuccess,
        colorText: vivid_colors.ttSnackBarSuccessText,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: vivid_colors.ttSnackBarFailure,
        colorText: vivid_colors.ttSnackBarFailureText,
      );
      print("Error creating user: $error");
    }
  }

  Future<void> updateUser(UserModel updatedUserData) async {
    try {
      final email = currentUserEmail.value;
      if (email.isNotEmpty) {
        final snapshot = await _db
            .collection("Users")
            .where("Email", isEqualTo: email)
            .get();
        final documentID = snapshot.docs.first.id;
        await _db
            .collection("Users")
            .doc(documentID)
            .update(updatedUserData.toJson());
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProfessionAttributes(
      String email, Map<String, String> attributesData) async {
    try {
      final snapshot =
      await _db.collection("Users").where("Email", isEqualTo: email).get();
      if (snapshot.docs.isNotEmpty) {
        final documentID = snapshot.docs.first.id;
        await _db.collection("Users").doc(documentID).update({
          'profession_attributes': FieldValue.arrayUnion(attributesData as List)
        });
      } else {
        print("User not found with email: $email");
      }
    } catch (error) {
      print("Error updating profession attributes: $error");
    }
  }

  Future<String?> getProfilePictureUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_profilePictureKey);
    } catch (error) {
      print("Error getting profile picture URL: $error");
      return null;
    }
  }

  Future<UserModel?> getUserDetails(String email) async {
    try {
      final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromSnapshot(snapshot.docs.first);
      }
    } catch (error) {
      print("Error fetching user details: $error");
    }
    return null;
  }
  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData =
    snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateADAttributes(Map<String, String> attributes) async {
    try {
      final email = currentUserEmail.value;
      if (email.isNotEmpty) {
        final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
        if (snapshot.docs.isNotEmpty) {
          final documentID = snapshot.docs.first.id;
          await _db.collection("Users").doc(documentID).update({
            'AD_attributes': attributes
          });
        } else {
          print("User not found with email: $email");
        }
      }
    } catch (error) {
      print("Error updating AD attributes: $error");
      throw error;
    }
  }

  Future<void> updateACAttributes(Map<String, String> attributes) async {
    try {
      final email = currentUserEmail.value;
      if (email.isNotEmpty) {
        final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
        if (snapshot.docs.isNotEmpty) {
          final documentID = snapshot.docs.first.id;
          await _db.collection("Users").doc(documentID).update({
            'AC_attributes': attributes
          });
        } else {
          print("User not found with email: $email");
        }
      }
    } catch (error) {
      print("Error updating AC attributes: $error");
      throw error;
    }
  }

  Future<void> updateActorAttributes(Map<String, String> attributes) async {
    try {
      final email = currentUserEmail.value;
      if (email.isNotEmpty) {
        final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
        if (snapshot.docs.isNotEmpty) {
          final documentID = snapshot.docs.first.id;
          await _db.collection("Users").doc(documentID).update({
            'actor_attributes': attributes
          });
        } else {
          print("User not found with email: $email");
        }
      }
    } catch (error) {
      print("Error updating Actor attributes: $error");
      throw error;
    }
  }

  Future<void> updateADRAttributes(Map<String, String> attributes) async {
    try {
      final email = currentUserEmail.value;
      if (email.isNotEmpty) {
        final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
        if (snapshot.docs.isNotEmpty) {
          final documentID = snapshot.docs.first.id;
          await _db.collection("Users").doc(documentID).update({
            'ADR_attributes': attributes
          });
        } else {
          print("User not found with email: $email");
        }
      }
    } catch (error) {
      print("Error updating ADR attributes: $error");
      throw error;
    }
  }

  Future<void> updateArtDirectorAttributes(
      Map<String, String> attributes) async {
    try {
      final email = currentUserEmail.value;
      if (email.isNotEmpty) {
        final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
        if (snapshot.docs.isNotEmpty) {
          final documentID = snapshot.docs.first.id;
          await _db.collection("Users").doc(documentID).update({
            'ArtDirector_attributes': attributes
          });
        } else {
          print("User not found with email: $email");
        }
      }
    } catch (error) {
      print("Error updating Art Director attributes: $error");
      throw error;
    }
  }
  String? getCurrentUserEmail() {
    return currentUserEmail.value.isNotEmpty ? currentUserEmail.value : null;
  }
}

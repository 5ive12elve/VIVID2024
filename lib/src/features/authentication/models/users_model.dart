import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  String fullname;
  final String email;
  String phoneNo;
  String governorate;
  String profession;
  String about; // New attribute for about information
  late final String profilePictureUrl;
  Map<String, String> professionAttributes;

  UserModel({
    this.id,
    required this.email,
    required this.fullname,
    required this.phoneNo,
    required this.governorate,
    required this.profession,
    this.about = '', // Provide a default value for about
    required this.profilePictureUrl,
    required this.professionAttributes,// Initialize profile picture URL field
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullname,
      "Email": email,
      "Phone": phoneNo,
      "Governorate": governorate,
      "Profession": profession,
      "About": about, // Include about information in JSON
      "ProfilePictureUrl": profilePictureUrl,
      "ProfessionAttributes": professionAttributes,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data["Email"],
      fullname: data["FullName"],
      phoneNo: data["Phone"],
      governorate: data["Governorate"],
      profession: data["Profession"],
      about: data["About"], // Retrieve about information from Firestore
      profilePictureUrl: data["ProfilePictureUrl"],
      professionAttributes: Map<String, String>.from(data["ProfessionAttributes"]),
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id}';
  }
}

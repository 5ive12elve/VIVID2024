import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profession_attributes_controller.dart';

class ProfessionAttributesScreen extends StatelessWidget {
  final String selectedProfessionValue;

  ProfessionAttributesScreen({required this.selectedProfessionValue});

  final ProfessionAttributesController controller = Get.put(ProfessionAttributesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProfessionValue),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildAttributesFields(selectedProfessionValue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.save),
      ),
    );
  }

  List<Widget> _buildAttributesFields(String selectedProfessionValue) {
    Map<String, List<String>> professionAttributes = {
      "1st AD (Assistant Director)": ["Skills", "Availability Schedule", "Experience", "Qualifications", "Work genres", "Preferred work genres", "Director collaborations", "Production Credits", "Salary"],
      "2nd AC (Assistant Camera)": ["Filming Experience", "Camera knowledge", "Lens Knowledge", "DIT collaboration", "Qualifications", "Organizing skills", "On-set Problem-solving", "Salary"],
      "Actor": ["Height", "Weight", "Eye color", "Hair Color", "Special Skills", "Languages they speak", "Availability", "Age", "Salary"],
      "ADR (Automated dialouge replacement) Mixer": ["Experience", "Projects", "Collaborations", "Equipment Knowledge", "Pro Tools Proficiency", "Availability", "Preferred Working Hours", "Salary"],
      "Art Director": ["Design Software Proficiency", "Adaptability and Flexibility", "Industry Focus", "Project Management", "Availability", "Salary"],
    };

    List<String> attributes = professionAttributes[selectedProfessionValue] ?? [];
    List<Widget> attributeFields = [];

    for (String attribute in attributes) {
      attributeFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attribute,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  // Update the attribute values in the controller
                  controller.setAttributeValue(attribute, value);
                },
              ),
            ],
          ),
        ),
      );
    }

    return attributeFields;
  }

  void _submitForm() {
    // Validate the form
    if (controller.areAttributesEmpty) {
      Get.snackbar(
        "Error",
        "Please fill out all the fields.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Call the controller method to update profession attributes
    controller.updateProfessionAttributes(selectedProfessionValue);
  }
}

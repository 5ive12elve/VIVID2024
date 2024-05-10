import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import '../features/profile/repository/user_repo.dart';
import '../features/search/controllers/search_bar_controller.dart';

class CustomSearch extends StatelessWidget {
  final SearchBarController controller = Get.find();
  final UserRepo userRepo = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        width: 345.0,
        height: 48.0,
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: vivid_colors.ttHeadColor, width: 1.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, color: vivid_colors.ttHeadColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  onChanged: (query) {
                    // Call searchUsers method when text changes
                    controller.searchUsers(query, userRepo.currentUserEmail.value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your search...',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Clear search results when clear icon is tapped
                controller.clearSearchResults();
              },
              child: Icon(Icons.clear, color: vivid_colors.ttHeadColor),
            ),
          ],
        ),
      ),
    );
  }
}

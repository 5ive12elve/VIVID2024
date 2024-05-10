import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import '../../../../features/authentication/models/users_model.dart';
import '../../../../features/chat/screens/messages_screen.dart';
import '../../../../features/search/controllers/search_bar_controller.dart';
import '../../../../features/search/widgets/search_bar_widget.dart';
import '../../../../common_widgets/custom_bar_search.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchBarController.to.clearSearchResults();

    return Scaffold(
      backgroundColor: vivid_colors.ttPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(),
              _buildCustomSearchBar(),
              SizedBox(height: 20),
              Obx(() => _buildSearchResults(SearchBarController.to.searchResults)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Title', // Customize as needed
            style: TextStyle(
              color: vivid_colors.ttHeadColor,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Subtitle', // Customize as needed
            style: TextStyle(
              color: vivid_colors.ttSubtitleColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }

  Widget _buildCustomSearchBar() {
    return CustomSearch();
  }

  Widget _buildSearchResults(RxList<UserModel> searchResults) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final UserModel user = searchResults[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SearchBarWidget(
              user: user,
              onMessagePressed: (chatroomId, receiverId) {
                // Navigate to MessagesScreen with the generated chatroom ID and receiver ID
                Get.to(() => MessagesScreen(chatroomId: chatroomId, receiverId: receiverId));
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import '../../authentication/models/users_model.dart';
import '../../chat/repository/chat_repo.dart';

class SearchBarWidget extends StatelessWidget {
  final UserModel user;
  final Function(String, String) onMessagePressed; // Updated function signature

  SearchBarWidget({required this.user, required this.onMessagePressed});

  @override
  Widget build(BuildContext context) {
    final ChatRepository chatRepository = Get.find(); // Retrieve ChatRepository instance

    return Container(
      width: double.infinity, // Adjust width as needed
      decoration: BoxDecoration(
        color: vivid_colors.ttContainerColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: user.profilePictureUrl != null
                ? NetworkImage(user.profilePictureUrl!)
                : AssetImage('assets/images/profile.jpg') as ImageProvider,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullname,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: vivid_colors.ttPrimaryColor,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  user.profession,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: vivid_colors.ttPrimaryColor,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  user.fullname,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: vivid_colors.ttYouuseloca,
                  ),
                ),
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: vivid_colors.ttYouuseloca,
                  ),
                ),
                Text(
                  user.governorate,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: vivid_colors.ttPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add your follow button logic here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color(0xFFFFF0D9),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Container(
                  width: 78.0,
                  height: 27.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Center(
                    child: Text('Follow'),
                  ),
                ),
              ),
              SizedBox(height: 8.0), // Add vertical spacing between buttons
              ElevatedButton(
                onPressed: () async {
                  String? currentUserUid = FirebaseAuth.instance.currentUser?.uid;
                  if (currentUserUid != null && user.id != null) {
                    print("Current User ID: $currentUserUid, Other User ID: ${user.id}");

                    String chatroomId = await chatRepository.getChatroomId(currentUserUid, user.id!);
                    if (chatroomId.isNotEmpty) {
                      onMessagePressed(chatroomId, user.id!); // Pass both chatroom ID and receiver ID
                    } else {
                      chatroomId = await chatRepository.createChatroom(currentUserUid, user.id!);
                      onMessagePressed(chatroomId, user.id!); // Pass both chatroom ID and receiver ID
                    }
                  } else {
                    print("Either current user is not logged in or the other user's ID is null");
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0.7, backgroundColor: Color(0x12000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), disabledForegroundColor: Color(0x12000000).withOpacity(0.38), disabledBackgroundColor: Color(0x12000000).withOpacity(0.12),
                  side: BorderSide(
                    color: Colors.black12,
                  ),
                ),
                child: Container(
                  width: 78.0,
                  height: 27.0,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF575757).withOpacity(0.04),
                        Color(0xFF575757).withOpacity(0.04),
                      ],
                    ),
                    backgroundBlendMode: BlendMode.colorDodge,
                  ),
                  child: Center(
                    child: Text(
                      'Message',
                      style: TextStyle(
                        color: vivid_colors.ttMessage,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

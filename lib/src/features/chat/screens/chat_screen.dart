import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vivid/src/constants/colors.dart';
import 'package:vivid/src/features/chat/screens/messages_screen.dart';
import '../../../common_widgets/custom_bar_search.dart';
import '../../authentication/models/users_model.dart';
import '../controllers/chat_screen_controller.dart';
import '../models/messages.dart';

class ChatScreen extends StatelessWidget {
  final ChatScreenController _chatScreenController = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(color: vivid_colors.ttHeadColor),
        ),
        backgroundColor: vivid_colors.primaryColor,
        centerTitle: true,
      ),
      body: Container(
        color: vivid_colors.primaryColor,
        child: Column(
          children: [
            CustomSearch(),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final sortedChatrooms = _chatScreenController.sortChatroomsByLastMessageTimestamp();
                return ListView.builder(
                  itemCount: sortedChatrooms.length,
                  itemBuilder: (context, index) {
                    final chatroom = sortedChatrooms[index];
                    return GestureDetector(
                      onTap: () async {
                        String? receiverId = await _chatScreenController.getLastMessageReceiverId(chatroom);
                        if (receiverId != null) {
                          Get.to(MessagesScreen(
                            chatroomId: chatroom.chatroomId,
                            receiverId: receiverId,
                          ));
                        } else {
                          print('Receiver ID not found for chatroom ${chatroom.chatroomId}');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: vivid_colors.secondaryColor,
                              radius: 30,
                              child: FutureBuilder<UserModel?>(
                                future: _chatScreenController.getReceiverDetailsFromLatestMessage(chatroom.chatroomId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final UserModel receiver = snapshot.data!;
                                    return CircleAvatar(
                                      backgroundImage: NetworkImage(receiver.profilePictureUrl),
                                      radius: 30,
                                    );
                                  } else {
                                    return Icon(Icons.person, color: vivid_colors.ttHeadColor);
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<UserModel?>(
                                    future: _chatScreenController.getReceiverDetailsFromLatestMessage(chatroom.chatroomId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final UserModel receiver = snapshot.data!;
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              receiver.fullname,
                                              style: TextStyle(
                                                color: vivid_colors.ttHeadColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            FutureBuilder<Message?>(
                                              future: _chatScreenController.getLastMessage(chatroom.chatroomId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final Message? lastMessage = snapshot.data;
                                                  final lastMessageTime = lastMessage!.timestamp;
                                                  final formattedTime = '${lastMessageTime.hour}:${lastMessageTime.minute}';
                                                  return Text(
                                                    formattedTime,
                                                    style: TextStyle(
                                                      color: vivid_colors.secondaryTextColor,
                                                      fontSize: 12,
                                                    ),
                                                  );
                                                } else {
                                                  return SizedBox.shrink(); // Hide if no last message
                                                }
                                              },
                                            ),
                                          ],
                                        );
                                      } else {
                                        return SizedBox.shrink(); // Hide if no receiver details
                                      }
                                    },
                                  ),
                                  SizedBox(height: 4),
                                  FutureBuilder<Message?>(
                                    future: _chatScreenController.getLastMessage(chatroom.chatroomId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final Message? lastMessage = snapshot.data;
                                        return Text(
                                          lastMessage!.message,
                                          style: TextStyle(
                                            color: vivid_colors.ttMessage,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        );
                                      } else {
                                        return SizedBox.shrink(); // Hide if no last message
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

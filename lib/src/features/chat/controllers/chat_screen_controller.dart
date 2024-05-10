import 'package:get/get.dart';
import 'package:vivid/src/features/chat/models/chatroom.dart';
import 'package:vivid/src/features/chat/repository/chat_repo.dart';
import '../../authentication/models/users_model.dart';
import '../models/messages.dart';

class ChatScreenController extends GetxController {
  final ChatRepository _chatRepository = Get.find();
  final RxList<Chatroom> chatrooms = <Chatroom>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChatrooms();
  }

  void fetchChatrooms() {
    _chatRepository.getChatrooms().listen(
          (chats) {
        chatrooms.assignAll(chats.toList());
        // Log the retrieved chatrooms
        print('Retrieved chatrooms: $chatrooms');
      },
      onError: (error) {
        // Handle error
        print('Error fetching chatrooms: $error');
      },
    );
  }

  Future<String?> getLastMessageReceiverId(Chatroom chatroom) async {
    try {
      // Retrieve the last message associated with the chatroom
      final lastMessage = await _chatRepository.getLastMessage(chatroom.chatroomId);
      if (lastMessage != null) {
        // Return the receiver ID from the last message
        return lastMessage.receiverId;
      } else {
        // Handle case where last message is null
        print('Last message not found for chatroom ${chatroom.chatroomId}');
        return null;
      }
    } catch (error) {
      // Handle error
      print('Error getting last message: $error');
      return null;
    }
  }

  Future<UserModel?> getReceiverDetailsFromLatestMessage(String chatroomId) async {
    try {
      // Retrieve the last message associated with the chatroom
      final lastMessage = await _chatRepository.getLastMessage(chatroomId);
      if (lastMessage != null) {
        // Return the receiver details from the last message
        return await _chatRepository.getUserDetails(lastMessage.receiverId);
      } else {
        // Handle case where last message is null
        print('Last message not found for chatroom $chatroomId');
        return null;
      }
    } catch (error) {
      // Handle error
      print('Error getting receiver details from latest message: $error');
      return null;
    }
  }

  Future<Message?> getLastMessage(String chatroomId) async {
    try {
      return await _chatRepository.getLastMessage(chatroomId);
    } catch (error) {
      // Handle error
      print('Error getting last message: $error');
      return null;
    }
  }

  List<Chatroom> sortChatroomsByLastMessageTimestamp() {
    chatrooms.sort((a, b) {
      final lastMessageA = a.lastMessageTs;
      final lastMessageB = b.lastMessageTs;
      return lastMessageB.compareTo(lastMessageA);
    });
    return chatrooms;
  }
}

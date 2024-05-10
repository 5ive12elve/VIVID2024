import 'package:get/get.dart';
import 'package:vivid/src/features/chat/repository/chat_repo.dart';
import '../models/messages.dart';

class MessagesScreenController extends GetxController {
  final ChatRepository _chatRepository = Get.find();
  final RxList<Message> messages = <Message>[].obs;

  late final String currentUserUid = _chatRepository.getCurrentUserUid();

  @override
  void onInit() {
    super.onInit();
  }

  void initialize(String chatroomId) {
    print("Initializing MessagesScreenController...");
    fetchMessages(chatroomId);
  }

  void fetchMessages(String chatroomId) {
    print("Fetching messages for chatroom: $chatroomId");
    _chatRepository.getMessages(chatroomId).listen(
          (messagesData) {
        messages.value = messagesData.toList();
        print("Received messages: ${messages.length}");
      },
      onError: (error) {
        print("Error fetching messages: $error");
      },
    );
  }

  void sendMessage(String message, String chatroomId, String receiverId) {
    _chatRepository.sendMessage(message, chatroomId, receiverId);
  }
}

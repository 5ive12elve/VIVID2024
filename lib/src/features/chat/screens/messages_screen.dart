import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/messages_screen_controller.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/bottom_chat_bar.dart';

class MessagesScreen extends StatefulWidget {
  final String chatroomId;
  final String receiverId;

  MessagesScreen({required this.chatroomId, required this.receiverId});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with WidgetsBindingObserver {
  late MessagesScreenController _messagesScreenController;
  late TextEditingController _controller;
  late ScrollController _scrollController;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _messagesScreenController = Get.put(MessagesScreenController());
    _controller = TextEditingController();
    _scrollController = ScrollController();
    _messagesScreenController.initialize(widget.chatroomId);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0;
    });
    if (_isKeyboardVisible) {
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF0D9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFF2A3A7D),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/chat_background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Obx(
                          () {
                        final messages = _messagesScreenController.messages.toList();
                        messages.sort((a, b) {
                          if (a.timestamp != null && b.timestamp != null) {
                            return a.timestamp!.compareTo(b.timestamp!);
                          } else {
                            return 0;
                          }
                        });
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          if (!_isKeyboardVisible) {
                            scrollToBottom();
                          }
                        });
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ChatBubble(
                                message: message.message,
                                isSender: message.senderId == _messagesScreenController.currentUserUid,
                                time: message.timestamp != null ? message.timestamp!.toString() : '',
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            BottomChatBar(
              onSendMessage: (message) {
                _messagesScreenController.sendMessage(message, widget.chatroomId, widget.receiverId);
              },
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}

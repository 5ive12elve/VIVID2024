import 'package:flutter/material.dart';

class BottomChatBar extends StatelessWidget {
  final Function(String) onSendMessage;
  final TextEditingController controller;

  const BottomChatBar({
    Key? key,
    required this.onSendMessage,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () {
                // Handle attachment button press
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    onSendMessage(value);
                    controller.clear();
                  },
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2A3A7D),
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Color(0xFFFFF0D9)),
              onPressed: () {
                String message = controller.text.trim();
                if (message.isNotEmpty) {
                  onSendMessage(message);
                  controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

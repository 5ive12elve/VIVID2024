import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.time,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color bubbleColor = isSender ? Color(0xFF5D6DB5) : Color(0xFFF8EEE2);
    final Color textColor = isSender ? Colors.white : Color(0xFF2A3A7D);

    String formattedTime = '';

    if (time.length >= 16) {
      formattedTime = time.substring(11, 16);
    } else {
      formattedTime = 'Invalid Time';
    }

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                formattedTime,
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

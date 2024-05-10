import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String messageId;
  final String senderId;
  final String receiverId;
  final DateTime timestamp; // Updated type to DateTime
  final bool seen;
  final String messageType;

  Message({
    required this.message,
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.seen,
    required this.messageType,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'],
      messageId: map['messageId'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
      seen: map['seen'],
      messageType: map['messageType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'messageId': messageId,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': Timestamp.fromDate(timestamp), // Convert DateTime to Firestore Timestamp
      'seen': seen,
      'messageType': messageType,
    };
  }

  factory Message.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Message(
      message: data['message'] ?? '',
      messageId: snapshot.id,
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
      seen: data['seen'] ?? false,
      messageType: data['messageType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': Timestamp.fromDate(timestamp), // Convert DateTime to Firestore Timestamp
      'seen': seen,
      'messageType': messageType,
    };
  }
}

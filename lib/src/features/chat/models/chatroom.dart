import 'package:cloud_firestore/cloud_firestore.dart';
import '../../authentication/models/users_model.dart';

class Chatroom {
  final String chatroomId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final List<String> members;
  final DateTime createdAt;
  final String receiverId;
  final String receiverName;
  late UserModel receiver;

  Chatroom({
    required this.chatroomId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.members,
    required this.createdAt,
    required this.receiverId,
    required this.receiverName,
  });

  factory Chatroom.fromMap(Map<String, dynamic> map, String id) {
    return Chatroom(
      chatroomId: id,
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTs: (map['lastMessageTs'] as Timestamp?)?.toDate() ?? DateTime.now(),
      members: List<String>.from(map['members'] ?? []),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      receiverId: map['receiverId'] ?? '', // Ensure receiverId is correctly retrieved
      receiverName: map['receiverName'] ?? '',
    );
  }

  factory Chatroom.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data != null) {
      return Chatroom.fromMap(data, snapshot.id);
    } else {
      // Handle null data gracefully, you can throw an error or return a default Chatroom object
      throw Exception("Snapshot data is null");
    }
  }

  void setReceiver(UserModel user) {
    receiver = user;
  }
}

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../../authentication/models/users_model.dart';
import '../models/chatroom.dart';
import '../models/messages.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Stream<Iterable<Chatroom>> getChatrooms() async* {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    yield* _db
        .collection("Chatrooms")
        .where("members", arrayContains: myUid)
        .snapshots()
        .asyncMap((snapshot) async {
      final chatrooms = snapshot.docs;
      final chatroomsWithDetails = <Chatroom>[];
      for (final chatroom in chatrooms) {
        final latestMessage = await getLastMessage(chatroom.id);
        if (latestMessage != null) {
          final receiverId = latestMessage.receiverId;
          final receiver = await getUserDetails(receiverId);
          if (receiver != null) {
            chatroomsWithDetails.add(Chatroom.fromSnapshot(chatroom));
          }
        }
      }
      return chatroomsWithDetails;
    });
  }

  Stream<Iterable<Message>> getMessages(String chatroomId) async* {
    yield* _db
        .collection("Chatrooms")
        .doc(chatroomId)
        .collection("Messages")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Message.fromSnapshot(doc)));
  }

  Future<void> sendMessage(String message, String chatroomId, String receiverId) async {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final now = DateTime.now();

    final newMessage = Message(
      message: message,
      messageId: '', // Firestore will generate the document ID automatically
      senderId: myUid,
      receiverId: receiverId,
      timestamp: now, // Assign current DateTime
      seen: false,
      messageType: 'text',
    );

    await _db.collection("Chatrooms").doc(chatroomId).collection("Messages").add({
      ...newMessage.toJson(), // Spread the message fields
      'timestamp': FieldValue.serverTimestamp(), // Use Firestore server timestamp
    });

    await _db.collection("Chatrooms").doc(chatroomId).update({
      "lastMessage": message,
      "lastMessageTs": now,
    });
  }

  Future<void> sendFileMessage(File file, String chatroomId, String receiverId, String messageType) async {
    final myUid = FirebaseAuth.instance.currentUser!.uid;
    final messageId = _db.collection("Chatrooms").doc(chatroomId).collection("Messages").doc().id;
    final now = DateTime.now();

    // Save to storage
    final ref = _storage.ref().child(messageType).child(messageId);
    final snapshot = await ref.putFile(file);
    final downloadUrl = await snapshot.ref.getDownloadURL();

    final newMessage = Message(
      message: downloadUrl,
      messageId: messageId,
      senderId: myUid,
      receiverId: receiverId,
      timestamp: now,
      seen: false,
      messageType: messageType,
    );

    await _db.collection("Chatrooms").doc(chatroomId).collection("Messages").doc(messageId).set(newMessage.toJson());

    await _db.collection("Chatrooms").doc(chatroomId).update({
      "lastMessage": 'send a $messageType',
      "lastMessageTs": now,
    });
  }

  Future<void> seenMessage(String chatroomId, String messageId) async {
    await _db
        .collection("Chatrooms")
        .doc(chatroomId)
        .collection("Messages")
        .doc(messageId)
        .update({"seen": true});
  }

  String getCurrentUserUid() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return currentUser.uid;
    } else {
      throw Exception('User not authenticated');
    }
  }

  Future<String> createChatroom(String currentUserUid, String otherUserUid) async {
    // Generate a unique chatroom ID
    String chatroomId = _generateChatroomId(currentUserUid, otherUserUid);

    // Check if the chatroom already exists
    var chatroomSnapshot = await _db.collection('Chatrooms').doc(chatroomId).get();
    if (chatroomSnapshot.exists) {
      return chatroomId;
    }

    // If the chatroom doesn't exist, create a new chatroom entry
    await _db.collection('Chatrooms').doc(chatroomId).set({
      'members': [currentUserUid, otherUserUid],
      // Add any other properties you need for your chatroom
    });

    return chatroomId;
  }

  String _generateChatroomId(String uid1, String uid2) {
    List<String> uids = [uid1, uid2]..sort();
    return '${uids[0]}_${uids[1]}';
  }

  Future<String> getChatroomId(String currentUserUid, String otherUserUid) async {
    String chatroomId = _generateChatroomId(currentUserUid, otherUserUid);
    // Check if the chatroom already exists
    var chatroomSnapshot = await _db.collection('Chatrooms').doc(chatroomId).get();
    if (chatroomSnapshot.exists) {
      return chatroomId;
    }
    return '';
  }

  Future<UserModel?> getUserDetails(String userId) async {
    try {
      print("Fetching user details for userId: $userId");
      final snapshot = await _db.collection("Users").doc(userId).get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        print("User snapshot does not exist for userId: $userId"); // Log if user snapshot does not exist
      }
    } catch (error) {
      print("Error fetching user details: $error");
    }
    return null;
  }

  Future<Message?> getLastMessage(String chatroomId) async {
    try {
      final snapshot = await _db
          .collection("Chatrooms")
          .doc(chatroomId)
          .collection("Messages")
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        // Retrieve the last message from the snapshot
        final lastMessage = Message.fromSnapshot(snapshot.docs.first);
        return lastMessage;
      } else {
        // If no messages are found, return null
        return null;
      }
    } catch (error) {
      // Handle error
      print("Error getting last message: $error");
      return null;
    }
  }

}

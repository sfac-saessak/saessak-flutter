
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saessak_flutter/model/user_model.dart';

class Message {
  String message;
  UserModel sender;
  Timestamp time;

  Message({
    required this.message,
    required this.sender,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'sender': this.sender.uid,
      'time': this.time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: map['message'] as String,
      sender: map['sender'] as UserModel,
      time: map['time'] as Timestamp,
    );
  }

  @override
  String toString() {
    return 'Message{message: $message, sender: $sender}';
  }
}

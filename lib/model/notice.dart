
import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  Timestamp writeTime;  // 작성 시간
  String title;         // 제목
  String content;       // 내용

  Notice({
    required this.writeTime,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'writeTime': this.writeTime,
      'title': this.title,
      'content': this.content,
    };
  }

  factory Notice.fromMap(Map<String, dynamic> map) {
    return Notice(
      writeTime: map['writeTime'] as Timestamp,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }
}

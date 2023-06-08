
import 'package:cloud_firestore/cloud_firestore.dart';

class Journal {
  String journalId;     // 일지 식별자
  String plantId;       // 대상 식물 id
  Timestamp writeTime;  // 작성 날짜
  bool bookmark;        // 북마크 여부
  String content;       // 일지 내용
  String? imageUrl;     // 이미지

  Journal({
    required this.journalId,
    required this.plantId,
    required this.writeTime,
    required this.bookmark,
    required this.content,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'journalId': this.journalId,
      'plantId': this.plantId,
      'writeTime': this.writeTime,
      'bookmark': this.bookmark,
      'content': this.content,
      'imageUrl': this.imageUrl,
    };
  }

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      journalId: map['journalId'] as String,
      plantId: map['plantId'] as String,
      writeTime: map['writeTime'] as Timestamp,
      bookmark: map['bookmark'] as bool,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String?,
    );
  }
}

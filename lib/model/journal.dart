
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'plant.dart';

class Journal {
  String? journalId;    // 일지 식별자
  Plant plant;          // 대상 식물
  String uid;           // 작성자 uid
  Timestamp writeTime;  // 작성 날짜
  RxBool bookmark;        // 북마크 여부
  String content;       // 일지 내용
  String? imageUrl;     // 이미지

  Journal({
    this.journalId,
    required this.plant,
    required this.uid,
    required this.writeTime,
    required this.bookmark,
    required this.content,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'journalId': this.journalId,
      'plant': plant.plantId,
      'uid': this.uid,
      'writeTime': this.writeTime,
      'bookmark': this.bookmark.value,
      'content': this.content,
      'imageUrl': this.imageUrl,
    };
  }

  factory Journal.fromMap(Map<String, dynamic> map) {
    return Journal(
      journalId: map['journalId'] as String?,
      plant: map['plant'] as Plant,
      uid: map['uid'] as String,
      writeTime: map['writeTime'] as Timestamp,
      bookmark: map['bookmark'] as RxBool,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String?,
    );
  }

  @override
  String toString() {
    return 'Journal{plant: $plant, content: $content}';
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  String? challengeId;  // 챌린지 식별자
  String plant;         // 주제 식물
  String admin;         // 챌린지 개설자 uid
  String title;         // 제목
  String content;       // 내용
  Timestamp createdAt;   // 생성 시간
  Timestamp startDate;   // 챌린지 시작 날짜
  Timestamp endDate;     // 챌린지 끝 날짜
  List? members;        // 참여 멤버 리스트
  int? memberLimit;     // 인원수
  String? imageUrl;     // 이미지

  Challenge({
    this.challengeId,
    required this.plant,
    required this.admin,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    this.members,
    this.memberLimit,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'challengeId': this.challengeId,
      'plant': this.plant,
      'admin': this.admin,
      'title': this.title,
      'content': this.content,
      'createdAt': this.createdAt,
      'startDate': this.startDate,
      'endDate': this.endDate,
      'members': this.members,
      'memberLimit': this.memberLimit,
      'imageUrl': imageUrl,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      challengeId: map['challengeId'] as String,
      plant: map['plant'] as String,
      admin: map['admin'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as Timestamp,
      startDate: map['startDate'] as Timestamp,
      endDate: map['endDate'] as Timestamp,
      members: map['members'] as List?,
      memberLimit: map['memberLimit'] as int?,
      imageUrl: map['imageUrl'] as String?,
    );
  }
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Post {

final Map userInfo;
final String title; 
final String content;
final List imgUrlList;
final int views;
final int reportNum;
final Timestamp writeTime;
final String tag;
final String postId; 

  Post({
    required this.userInfo,
    required this.title,
    required this.content,
    required this.imgUrlList,
    required this.views,
    required this.reportNum,
    required this.writeTime,
    required this.tag,
    required this.postId
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userInfo': userInfo,
      'title': title,
      'content': content,
      'imgUrlList': imgUrlList,
      'views': views,
      'reportNum': reportNum,
      'writeTime': writeTime.millisecondsSinceEpoch,
      'tag': tag,
      'postId': postId,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userInfo: map['userInfo'] as Map,
      title: map['title'] as String,
      content: map['content'] as String,
      imgUrlList: map['imgUrlList'] as List,
      views: map['views'] as int,
      reportNum: map['reportNum'] as int,
      writeTime: map['writeTime'] as Timestamp,
      tag: map['tag'] as String,
      postId: map['postId'] as String,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);
}

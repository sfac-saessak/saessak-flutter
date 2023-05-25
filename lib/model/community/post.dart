// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {

final Map userInfo;
final String title; 
final String content;
final List<String> photoURL;
final int views;
final int reportNum;
final List<Map> comments;
final Timestamp writeTime;
  Post({
    required this.userInfo,
    required this.title,
    required this.content,
    required this.photoURL,
    required this.views,
    required this.reportNum,
    required this.comments,
    required this.writeTime
  });

}


class UserModel {
  final String uid;
  final String email;
  final String name;
  final String? profileImg;
  final List? challenges;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.profileImg,
    this.challenges,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name': this.name,
      'profileImg': this.profileImg,
      'challenges': this.challenges,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      profileImg: map['profileImg'] as String?,
      challenges: map['challenges'] as List?,
    );
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, name: $name, profileImg: $profileImg, challenges: $challenges}';
  }
}

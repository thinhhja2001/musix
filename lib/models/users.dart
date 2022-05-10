import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String username;
  final String uid;
  final List followers;
  final List following;
  final String avatarUrl;

  Users(
      {required this.email,
      required this.username,
      required this.uid,
      required this.followers,
      required this.following,
      required this.avatarUrl});

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
        email: snapshot['email'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        avatarUrl: snapshot['img_url']);
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "followers": followers,
        "following": following,
        "uid": uid,
        "img_url": avatarUrl,
      };
}

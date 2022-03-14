import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String uid;
  final List followers;
  final List following;

  User(
      {required this.email,
      required this.username,
      required this.uid,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        email: snapshot['email'],
        username: snapshot['username'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following']);
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "followers": followers,
        "following": following,
        "uid": uid,
      };
}

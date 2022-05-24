import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import '../models/users.dart';

class ProfileMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

  void _changePassword(String Password, String newPassword) async {
    String? email = user!.email;

    //Create field for user to input old password

    //pass the password here
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: Password,
      );

      user?.updatePassword(newPassword).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<String> uploadImage(File image) async {
    String fileName = basename(image.path);
    Reference storageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    await storageRef.putFile(image);
    String downloadURL = await storageRef.getDownloadURL();
    print("Download url = " + downloadURL);
    return downloadURL;
  }

  Future<void> setUserProfile(
      Users user, File? image, String username, String imageURL) async {
    if (image != null) {
      imageURL = await uploadImage(image);
    }
    await _firestore.collection("users").doc(user.uid).set({
      'username': username,
      'uid': user.uid,
      'email': user.email,
      'img_url': imageURL,
      'followers': [],
      'following': []
    });
  }
}

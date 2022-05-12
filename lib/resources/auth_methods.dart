import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musix/models/users.dart';
import 'package:path/path.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<Users> getCurrentUser() async {
    Users users;
    print(user!.uid);
    final DocumentSnapshot userDoc =
        await _firestore.collection("users").doc(user!.uid).get();
    users = new Users(
        email: userDoc['email'],
        username: userDoc['username'],
        uid: user!.uid,
        followers: userDoc['followers'],
        following: userDoc['following'],
        avatarUrl: userDoc['img_url']);
    return users;
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

  Future<bool> checkUserNameExisted({required String username}) async {
    bool isUserNameExisted = false;
    await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get()
        .then((querySnapshot) => {
              if (querySnapshot.size == 0)
                {isUserNameExisted = false}
              else
                {isUserNameExisted = true}
            });
    return isUserNameExisted;
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

  Future<void> setUserProfile(Users user, File? image, String username, String imageURL) async {
    if(image != null)
    {
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

  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required DateTime? birthday}) async {
    String res = "Some error occurred";
    bool isUserNameExisted = await checkUserNameExisted(username: username);
    if (isUserNameExisted) {
      res = "Username existed";
      return res;
    }

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          birthday != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'birthday': birthday,
          'img_url': "",
          'followers': [],
          'following': []
        });

        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      print(err.code);
      if (err.code == 'invalid-email') {
        return 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        return 'Your password must be at least 6 characters';
      } else if (err.code == "email-already-in-use") {
        return 'Email already in use';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  /// This function will be called in loginWithFacebook and loginWithGoogle methods.
  /// If user chose to loginWithFacebook or Google without creating an account first, Firestore Database will create one account in FirestoreDatabase
  Future<String> autoSignUpUser(UserCredential userCredential) async {
    String result = "success";
    User user = userCredential.user!;
    await _firestore.collection("users").doc(user.uid).set({
      'username': user.displayName,
      'uid': user.uid,
      'email': user.email,
      'img_url': "",
      'followers': [],
      'following': []
    });
    return result;
  }

  //login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String result = "success";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(userCredential.user!.email);
      }
    } on FirebaseAuthException catch (e) {
      print("error return " + e.code);
      if (e.code == "user-not-found") {
        result = "No user found for that email";
      } else if (e.code == "wrong-password") {
        result = "Incorrect password";
      } else if (e.code == "invalid-email") {
        result = "The email is badly formatted";
      } else {
        result = "Some error occurred, please try again later";
      }
    }
    return result;
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    await checkUserExisted(userCredential);
    return userCredential;
  }

  Future<UserCredential> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    UserCredential userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);
    bool checkResult = await checkUserExisted(userCredential);
    print("user is" + checkResult.toString());
    return userCredential;
  }

  ///Check if the user currently logged in by using Google or Facebook
  ///is already existed in FirestoreDatabase.
  ///If it is already existed, return true, else, it will call autoSignUpUser method and return false
  Future<bool> checkUserExisted(UserCredential userCredential) async {
    bool result = true;
    await _firestore
        .collection("users")
        .doc(userCredential.user!.uid)
        .get()
        .then((snapshot) => {
              if (snapshot.exists)
                {result = true}
              else
                {result = false, autoSignUpUser(userCredential)}
            });

    return result;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musix/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
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
      'followers': [],
      'following': []
    });
    return result;
  }

  //login user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String result = "Login success";
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

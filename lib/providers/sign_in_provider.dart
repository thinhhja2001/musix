import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/screens/email_verification_screen.dart';

class SignInProvider extends ChangeNotifier {
  bool _isValid = true;
  bool get isValid => _isValid;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<String> signInUser(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Please fill up all the field";
      _isValid = false;
      notifyListeners();
      return _errorMessage;
    }
    _isLoading = true;
    notifyListeners();

    _errorMessage =
        await AuthMethods().loginUser(email: email, password: password);
    notifyListeners();
    if (_errorMessage == "Login success") {
      _isValid = true;
      final User user = FirebaseAuth.instance.currentUser!;
      if (!user.emailVerified) {
        Get.offAll(EmailVerificationScreen());
      }
    } else {
      _isValid = false;
    }
    _isLoading = false;
    notifyListeners();
    return _errorMessage;
  }
}

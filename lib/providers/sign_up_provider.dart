import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/screens/email_verification_screen.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isValid = true;
  bool get isValid => _isValid;

  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  DateTime? _birthDay;
  DateTime? get birthDay => _birthDay;
  void updateBirthDay(DateTime? birthDay) {
    _birthDay = birthDay;
    notifyListeners();
  }

  void reset() {
    _errorMessage = "";
    _isLoading = false;
    _birthDay = null;
    notifyListeners();
  }

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username}) async {
    if (email.isEmpty ||
        password.isEmpty ||
        username.isEmpty ||
        birthDay == null) {
      _isValid = false;
      _errorMessage = "Please fill out all the field";
      notifyListeners();
      return _errorMessage;
    }
    _isLoading = true;
    notifyListeners();
    _errorMessage = await AuthMethods().signUpUser(
        email: email,
        password: password,
        username: username,
        birthday: birthDay);
    if (_errorMessage == "success") {
      _isValid = true;
      SignUpProvider().reset();
      Get.to(EmailVerificationScreen());
    } else {
      _isValid = false;
    }
    _isLoading = false;
    notifyListeners();
    return _errorMessage;
  }
}

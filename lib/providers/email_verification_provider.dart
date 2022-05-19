import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:musix/providers/sign_in_provider.dart';
import 'package:musix/screens/signin_screen.dart';

class EmailVerificationProvider extends ChangeNotifier {
  bool _isLoading = false;
  final User _user = FirebaseAuth.instance.currentUser!;

  /// _currentState represent for current state of the screen.
  /// It is "false" if current state is when the user haven't click the send email button yet,
  /// and it will is "true" if the user clicked the send email button

  bool _currentState = false;
  String title = "Just one more step";
  String description = "We will send a verification link to this email";
  String buttonContent = "Submit";
  get currentState => _currentState;
  get isLoading => _isLoading;
  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void reset() {
    _currentState = false;
    title = "Just one more step";
    description = "We will send a verification link to this email";
    buttonContent = "Submit";
  }

  void onSubmitClick() async {
    //User haven't clicked the send email button yet
    if (_currentState == false) {
      await sendEmailVerification();
      changeCurrentState();
    } else {
      reset();
      SignInProvider().reset();
      Get.offAll(const SignInScreen());
    }
  }

  void changeCurrentState() {
    if (_currentState == false) {
      _currentState = true;
      title = "Email sent";
      description = "Please check your email and confirm";
      buttonContent = "Go to Login screen";
    }
  }

  Future<String> sendEmailVerification() async {
    if (!_user.emailVerified) {
      setIsLoading(true);
      await _user.sendEmailVerification();
      setIsLoading(false);
      Get.snackbar("Email sent", "An email has been sent to ${_user.email}");
      return "success";
    }
    return "failed";
  }
}

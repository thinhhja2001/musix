import 'package:flutter/src/widgets/framework.dart';

class SignUpTextPath {
  String get signUpTitle => r'Sign Up';
  String get signUpDescription =>
      r'Welcome to MusiX, which will make accompany your mood for music. Let’s create account now';

  String get userName => r'Username';
  String get emailAddress => r'Email Address';
  String get fullName => r'Your name';
  String get password => r'Password';
  String get phoneNumber => r'Your phone number';
  String get birthday => r'Birthday';
  String get passwordConfirm => r'Confirm password';

  String get createAccount => r'Create Account';
  String get haveAccount => r'You have Account yet?';
  String get signIn => r'Sign In';

  String get emptyUserName => r'Username cannot be empty';
  String get emptyEmail => r'Email cannot be empty';
  String get invalidEmail => r'Email invalid';
  String get emptyPassword => r'Password cannot be empty';
  String get emptyPhoneNumber => r'Phone number cannot be empty';
  String get emptyBirthday => r'Birthday cannot be empty';

  String get invalidPhoneNumber => r'Invalid phone number';

  String get passwordConfirmDoesNotMatch => r'Password confirm does not match';

  String get emptyPasswordConfirm => r'Password confirm cannot be empty';
}

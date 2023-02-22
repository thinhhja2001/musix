import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';
import 'utils/text_path.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpTextPath = SignUpTextPath();
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  DateTime? _birthDay;
  String? _errorBirthday;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: ColorTheme.background,
        resizeToAvoidBottomInset: false,
        body: TemplateWidget(
          coverImage: AssetPath.signUpCover,
          header: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  signUpTextPath.signUpTitle,
                  style: TextStyleTheme.ts28.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  signUpTextPath.signUpDescription,
                  style: TextStyleTheme.ts15.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              CustomInputFieldWidget(
                customInputFieldType: CustomInputFieldType.text,
                label: signUpTextPath.userName,
                controller: _userNameController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return signUpTextPath.emptyUserName;
                  }
                  return null;
                },
              ),
              CustomInputFieldWidget(
                customInputFieldType: CustomInputFieldType.text,
                label: signUpTextPath.emailAddress,
                controller: _emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return signUpTextPath.emptyEmail;
                  } else if (!EmailValidator.validate(value)) {
                    return signUpTextPath.invalidEmail;
                  }
                  return null;
                },
              ),
              CustomInputFieldWidget(
                customInputFieldType: CustomInputFieldType.password,
                label: signUpTextPath.password,
                controller: _passwordController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return signUpTextPath.emptyPassword;
                  }
                  return null;
                },
              ),
              CustomDatePickerWidget(
                label: signUpTextPath.birthday,
                datePicker: _birthDay,
                pickDateFunction: (value) {
                  setState(() {
                    if (_errorBirthday != null) {
                      _errorBirthday = null;
                    }
                    _birthDay = value;
                  });
                },
                error: _errorBirthday,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomButtonWidget(
                onPress: () async {
                  int countError = 0;
                  if (_birthDay == null) {
                    setState(() {
                      _errorBirthday = signUpTextPath.emptyBirthday;
                    });
                    countError++;
                  }
                  if (_formKey.currentState!.validate()) {
                    if (countError == 1) {
                      return;
                    }
                  }
                  // String result = await signUpProvider.signUpUser(
                  //     email: _emailController.text,
                  //     password: _passwordController.text,
                  //     username: _usernameController.text);
                  // if (result == "success") {
                  //   signUpProvider.reset();
                  // }
                },
                content: signUpTextPath.createAccount,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    signUpTextPath.haveAccount,
                    style: TextStyleTheme.ts15.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutingPath.signIn);
                    },
                    child: Text(
                      signUpTextPath.signIn,
                      style: TextStyleTheme.ts15.copyWith(
                        color: ColorTheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

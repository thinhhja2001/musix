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
        body: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              AssetPath.signUpCover1,
                            ),
                            fit: BoxFit.fill),
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack()),
                ),
                Flexible(flex: 1, child: Container())
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      color: ColorTheme.backgroundDarker,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: ColorTheme.primary, spreadRadius: 3)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
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
                                Navigator.pushNamed(
                                    context, RoutingPath.signIn);
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
                      ]),
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

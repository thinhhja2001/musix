import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:musix/providers/sign_up_provider.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/screens/email_verification_screen.dart';
import 'package:musix/screens/signin_screen.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';

import 'package:provider/provider.dart';

import '../widgets/customs/custom_button.dart';
import '../widgets/customs/custom_datepicker_field.dart';
import '../widgets/customs/custom_error_box.dart';
import '../widgets/customs/custom_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ]).createShader(
                        Rect.fromLTRB(0, -140, rect.width, rect.height * 0.8));
                  },
                  blendMode: BlendMode.darken,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: ExactAssetImage(
                                "assets/images/signup_cover.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05,
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                                "\nWelcome to MusiX, which will make accompany your mood for music. Let's create account now\n",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: kPrimaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Color(0xff28333F),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Column(
                        children: [
                          CustomInputField(
                            customInputFieldType: CustomInputFieldType.text,
                            label: "Username",
                            controller: _usernameController,
                          ),
                          CustomInputField(
                            customInputFieldType: CustomInputFieldType.text,
                            label: "Email address",
                            controller: _emailController,
                          ),
                          CustomInputField(
                            customInputFieldType: CustomInputFieldType.password,
                            label: "Password",
                            controller: _passwordController,
                          ),
                          const CustomDatePickerField(),
                          signUpProvider.isValid
                              ? Container()
                              : CustomErrorBox(
                                  message: signUpProvider.errorMessage,
                                ),
                          CustomButton(
                            onPress: () async {
                              String result = await signUpProvider.signUpUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  username: _usernameController.text);
                              if (result == "success") {
                                signUpProvider.reset();
                              }
                            },
                            content: "Create account",
                            isLoading: signUpProvider.isLoading,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "You have account?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextButton(
                                  onPressed: () {
                                    signUpProvider.reset();
                                    Get.to(const SignInScreen());
                                  },
                                  child: const Text(
                                    "Sign in",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w600),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

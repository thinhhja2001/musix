import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/providers/email_verification_provider.dart';
import 'package:musix/providers/sign_in_provider.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/screens/email_verification_screen.dart';
import 'package:musix/screens/home_screen.dart';
import 'package:musix/screens/signup_screen.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/forget_password_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/customs/custom_button.dart';
import '../widgets/customs/custom_error_box.dart';
import '../widgets/customs/custom_input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
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
                                "assets/images/signin_cover.png"),
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
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                                "\nWelcome back to MusiX, it's time to listen to the music you want and enjoy the music!\n",
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
              flex: 4,
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
                            label: "Email address",
                            controller: _emailController,
                          ),
                          CustomInputField(
                            customInputFieldType: CustomInputFieldType.password,
                            label: "Password",
                            controller: _passwordController,
                          ),
                          signInProvider.isValid
                              ? Container()
                              : CustomErrorBox(
                                  message: signInProvider.errorMessage),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => ForgetPassword(),
                                      isScrollControlled: true,
                                      backgroundColor:
                                          Color.fromRGBO(40, 51, 63, 1),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0)),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot your password?",
                                    style: TextStyle(color: kPrimaryColor),
                                  ))
                            ],
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              CustomButton(
                                onPress: () async {
                                  Provider.of<EmailVerificationProvider>(
                                          context,
                                          listen: false)
                                      .reset();
                                  String result =
                                      await signInProvider.signInUser(
                                          email: _emailController.text,
                                          password: _passwordController.text);
                                  if (result == "success") {
                                    Get.offAll(const HomeScreen());
                                  }
                                },
                                content: "Sign in",
                                isLoading: signInProvider.isLoading,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have account?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(const SignUpScreen());
                                      },
                                      child: const Text(
                                        "Sign up",
                                        style: TextStyle(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w600),
                                      ))
                                ],
                              )
                            ],
                          ))
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musix/providers/google_sign_in.dart';
import 'package:musix/resources/auth_methods.dart';
import 'package:musix/screens/signin_screen.dart';
import 'package:musix/screens/signup_screen.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/custom_button.dart';
import 'package:musix/widgets/social_media_login_button.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black])
                .createShader(
                    Rect.fromLTRB(0, -140, rect.width, rect.height * 0.8));
          },
          blendMode: BlendMode.darken,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("assets/images/onboarding_bg.png"),
                    fit: BoxFit.fill)),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/app_icon.svg",
                  height: 50,
                  width: 50,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    "Millions of Songs.",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 28),
                  ),
                ),
                const Text(
                  "Free on MusiX",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 28),
                ),
                CustomButton(
                  onPress: () {
                    Get.to(const SignUpScreen());
                  },
                  content: 'Sign up free',
                  isLoading: _isLoading,
                ),
                SocialMediaLoginButton(
                  socialLoginType: SocialLoginType.google,
                  onPress: loginWithGoogle,
                ),
                SocialMediaLoginButton(
                  socialLoginType: SocialLoginType.facebook,
                  onPress: loginWithFacebook,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kButtonMarginTop * 3),
                  child: TextButton(
                      onPressed: () {
                        Get.to(const SignInScreen());
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  void loginWithGoogle() async {
    final UserCredential userCredential = await AuthMethods().loginWithGoogle();

    print(userCredential.user!.email);
  }

  void loginWithFacebook() async {
    final UserCredential userCredential =
        await AuthMethods().loginWithFacebook();

    print(userCredential.user!.displayName);
  }
}

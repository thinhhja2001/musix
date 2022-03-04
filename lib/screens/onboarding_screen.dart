import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/screens/signup_screen.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/custom_button.dart';
import 'package:musix/widgets/social_media_login_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  content: 'Sign up free',
                ),
                SocialMediaLoginButton(
                  socialLoginType: SocialLoginType.google,
                  onPress: () {},
                ),
                SocialMediaLoginButton(
                  socialLoginType: SocialLoginType.facebook,
                  onPress: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: kButtonMarginTop * 3),
                  child: TextButton(
                      onPressed: () {},
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
}

import 'package:flutter/material.dart';
import 'package:musix/utils/constant.dart';

import '../utils/enums.dart';

class SocialMediaLoginButton extends StatelessWidget {
  const SocialMediaLoginButton({
    Key? key,
    required this.onPress,
    required this.socialLoginType,
  }) : super(key: key);
  final VoidCallback onPress;
  final SocialLoginType socialLoginType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kButtonMarginTop,
      ),
      child: InkWell(
        onTap: onPress,
        child: SizedBox(
            width: double.infinity,
            height: 42,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  socialLoginType == SocialLoginType.facebook
                      ? "assets/images/facebook_icon.png"
                      : "assets/images/google_icon.png",
                  height: 30,
                  width: 30,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      socialLoginType == SocialLoginType.facebook
                          ? "Continue with Facebook"
                          : "Continue with Google",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

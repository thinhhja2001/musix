import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musix/providers/email_verification_provider.dart';
import 'package:musix/screens/signin_screen.dart';
import 'package:musix/utils/constant.dart';
import 'package:provider/provider.dart';

import '../widgets/customs/custom_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({Key? key}) : super(key: key);
  final User _user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final emailVerificationProvider =
        Provider.of<EmailVerificationProvider>(context);

    return Scaffold(
        backgroundColor: const Color(0xff28333F),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      children: [
                        SvgPicture.asset("assets/images/Rating.svg"),
                        verticalSpaceTiny,
                        Text(
                          emailVerificationProvider.title,
                          style: kDefaultTextStyle.copyWith(fontSize: 22),
                        ),
                        verticalSpaceTiny,
                        Text(
                          emailVerificationProvider.description,
                          style: kDefaultTextStyle.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          _user.email!,
                          style: kDefaultTextStyle.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: CustomButton(
                              onPress: emailVerificationProvider.onSubmitClick,
                              content: emailVerificationProvider.buttonContent,
                              isLoading: emailVerificationProvider.isLoading),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You have an account?",
                              style: kDefaultTextStyle.copyWith(
                                  fontWeight: FontWeight.w300, fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.offAll(const SignInScreen());
                                },
                                child: Text(
                                  "Login",
                                  style:
                                      kDefaultTextStyle.copyWith(fontSize: 15),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/providers/email_verification_provider.dart';
import 'package:musix/screens/signin_screen.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({Key? key}) : super(key: key);
  final User _user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    final emailVerificationProvider =
        Provider.of<EmailVerificationProvider>(context);

    void sendEmailVerification() async {
      if (!_user.emailVerified) {
        emailVerificationProvider.setIsLoading(true);
        await _user.sendEmailVerification();
        emailVerificationProvider.setIsLoading(false);
        showSnackBar("Email sent", context);
      }
    }

    ;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset("assets/images/Rating.svg"),
                      verticalSpaceTiny,
                      Text(
                        "Just one more step",
                        style: kTextStyle.copyWith(fontSize: 22),
                      ),
                      verticalSpaceTiny,
                      Text(
                        "We will send a verification link to this email",
                        style: kTextStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      verticalSpaceRegular,
                      Text(
                        _user.email!,
                        style: kTextStyle.copyWith(fontSize: 15),
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
                            onPress: sendEmailVerification,
                            content: "Submit",
                            isLoading: emailVerificationProvider.isLoading),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have an account?",
                            style: kTextStyle.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 15),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()));
                              },
                              child: Text(
                                "Login",
                                style: kTextStyle.copyWith(fontSize: 15),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

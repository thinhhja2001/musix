import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_user/views/forget_password_screen/utils/text_path.dart';

import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordTextPath forgetPasswordTextPath =
      ForgetPasswordTextPath();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
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
          coverImage: AssetPath.signInCover,
          header: Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  forgetPasswordTextPath.forgetPasswordTitle,
                  style: TextStyleTheme.ts28.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
                // Text(
                //   signInTextPath.signInDescription,
                //   style: TextStyleTheme.ts15.copyWith(
                //     color: Colors.white,
                //     fontWeight: FontWeight.w300,
                //   ),
                // ),
              ],
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                forgetPasswordTextPath.instruction,
                style: TextStyleTheme.ts15.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomInputFieldWidget(
                customInputFieldType: CustomInputFieldType.text,
                label: forgetPasswordTextPath.emailAddress,
                controller: _emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return forgetPasswordTextPath.emptyEmail;
                  } else if (!EmailValidator.validate(value)) {
                    return forgetPasswordTextPath.invalidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              CustomButtonWidget(
                content: forgetPasswordTextPath.resendEmail,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    // auth.sendPasswordResetEmail(email: _email.text);
                    // Navigator.pop(context);
                    // Fluttertoast.showToast(
                    //   msg:
                    //       "A mail have just been sent to your email\n Please check your email to reset your password!",
                    //   toastLength: Toast.LENGTH_LONG,
                    //   gravity: ToastGravity.BOTTOM,
                    // );
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    forgetPasswordTextPath.cancel,
                    style: TextStyleTheme.ts15.copyWith(
                      color: ColorTheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

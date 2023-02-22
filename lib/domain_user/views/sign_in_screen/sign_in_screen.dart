import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../../routing/routing_path.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';
import 'utils/text_path.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final signInTextPath = SignInTextPath();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                  signInTextPath.signInTitle,
                  style: TextStyleTheme.ts28.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  signInTextPath.signInDescription,
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
                label: signInTextPath.emailAddress,
                controller: _emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return signInTextPath.emptyEmail;
                  } else if (!EmailValidator.validate(value)) {
                    return signInTextPath.invalidEmail;
                  }
                  return null;
                },
              ),
              CustomInputFieldWidget(
                customInputFieldType: CustomInputFieldType.password,
                label: signInTextPath.password,
                controller: _passwordController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return signInTextPath.emptyPassword;
                  }
                  return null;
                },
              ),
              // signInProvider.isValid
              //     ? Container()
              //     : CustomErrorBox(
              //         message: signInProvider.errorMessage),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RoutingPath.forgetPassword);
                      },
                      child: Text(
                        signInTextPath.forgetPassword,
                        style: TextStyleTheme.ts15.copyWith(
                          color: ColorTheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ))
                ],
              ),
              Expanded(
                  child: Column(
                children: [
                  CustomButtonWidget(
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, RoutingPath.home);
                        // String result =
                        //     await signInProvider.signInUser(
                        //         email: _emailController.text,
                        //         password: _passwordController.text);
                        // if (result == "success") {
                        //   Get.offAll(const HomeScreen());
                        // }
                      }
                    },
                    content: signInTextPath.signIn,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        signInTextPath.notHaveAccount,
                        style: TextStyleTheme.ts15.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutingPath.signUp);
                        },
                        child: Text(
                          signInTextPath.signUp,
                          style: TextStyleTheme.ts15.copyWith(
                            color: ColorTheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

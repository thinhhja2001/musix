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
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorTheme.background,
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
                              AssetPath.signInCover1,
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
                      child: Column(
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
                          const Spacer(),
                          Expanded(
                              child: Column(
                            children: [
                              CustomButtonWidget(
                                onPress: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pushNamed(
                                        context, RoutingPath.home);
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
                                      Navigator.pushNamed(
                                          context, RoutingPath.signUp);
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

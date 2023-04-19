import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/utils/utils.dart';

import '../../../../config/exporter.dart';
import '../../../../routing/routing_path.dart';
import '../../../../theme/color.dart';
import '../../../../theme/text_style.dart';
import '../../../payload/request/login_request.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_error_box.dart';
import '../../widgets/custom_textfield_widget.dart';
import 'utils/text_path.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController =
      TextEditingController(text: "usertest");
  final TextEditingController _passwordController =
      TextEditingController(text: "123456");
  final _formKey = GlobalKey<FormState>();
  final signInTextPath = SignInTextPath();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: (context, state) async {
      if (state.loginStatus == 200) {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutingPath.home, (Route<dynamic> route) => false);
      }
    }, child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
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
                                  AssetPath.signInCover,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
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
                              BoxShadow(
                                  color: ColorTheme.primary, spreadRadius: 3)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CustomInputFieldWidget(
                                textInputType: TextInputType.text,
                                label: signInTextPath.username,
                                controller: _usernameController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signInTextPath.emptyUsername;
                                  }
                                  return null;
                                },
                              ),
                              CustomInputFieldWidget(
                                textInputType: TextInputType.visiblePassword,
                                label: signInTextPath.password,
                                controller: _passwordController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signInTextPath.emptyPassword;
                                  }
                                  return null;
                                },
                              ),
                              (state.loginStatus != 200 &&
                                      state.loginStatus != null)
                                  ? CustomErrorBox(
                                      message:
                                          state.loginMsg ?? "Unknown Error",
                                    )
                                  : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            RoutingPath.requestForgetOtp);
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
                                    onPress: state.isLoginLoading == true
                                        ? () {}
                                        : () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<AuthBloc>()
                                                  .add(AuthLoginEvent(
                                                    LoginRequest(
                                                        username:
                                                            _usernameController
                                                                .text,
                                                        password:
                                                            _passwordController
                                                                .text),
                                                  ));
                                            }
                                          },
                                    content: signInTextPath.signIn,
                                    isLoading: state.isLoginLoading,
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
      },
    ));
  }
}

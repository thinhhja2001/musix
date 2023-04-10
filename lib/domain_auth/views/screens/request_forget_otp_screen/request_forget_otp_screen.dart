import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_auth/entities/event/auth_event.dart';
import 'package:musix/domain_auth/views/screens/email_verification_screen/utils/function.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_auth/views/widgets/custom_error_box.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../entities/state/auth_state.dart';
import '../../../logic/auth_bloc.dart';
import '../../widgets/custom_textfield_widget.dart';
import 'utils/text_path.dart';

class RequestForgetOTPScreen extends StatelessWidget {
  RequestForgetOTPScreen({super.key});
  final RequestForgetOtpTextPath requestForgetOtpTextPath =
      RequestForgetOtpTextPath();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, current) {
        return (current.requestResetStatus == 200 &&
            current.isRequestResetLoading == false &&
            prev.requestResetStatus != 200);
      },
      listener: (context, state) {
        if (state.requestResetStatus == 200) {
          showSnackBar(context,
              title: "Success",
              content: "Email sent",
              contentType: ContentType.success);
          context
              .read<AuthBloc>()
              .add(AuthResetCurrentRequestPasswordStateEvent());
          Navigator.of(context).pushNamed(RoutingPath.resetPassword);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
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
                                    AssetPath.forgotCover,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                requestForgetOtpTextPath.forgetPasswordTitle,
                                style: TextStyleTheme.ts28.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  requestForgetOtpTextPath.instruction,
                                  style: TextStyleTheme.ts15.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomInputFieldWidget(
                                        textInputType:
                                            TextInputType.emailAddress,
                                        label: 'Your email',
                                        controller: _emailController,
                                        validation: (value) {
                                          if (value == null) {
                                            return requestForgetOtpTextPath
                                                .emptyEmail;
                                          }
                                          if (!EmailValidator.validate(value)) {
                                            return requestForgetOtpTextPath
                                                .invalidEmail;
                                          }
                                          return null;
                                        },
                                      ),
                                      (state.requestResetStatus != null &&
                                              state.requestResetStatus != 200)
                                          ? CustomErrorBox(
                                              message: state.requestResetMsg ??
                                                  "Unknown error")
                                          : Container(),
                                      const Spacer(),
                                      CustomButtonWidget(
                                          isLoading:
                                              state.isRequestResetLoading,
                                          onPress: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<AuthBloc>().add(
                                                  AuthRequestResetPasswordEvent(
                                                      _emailController
                                                          .value.text));
                                            }
                                          },
                                          content: 'Send OTP'),
                                      const SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                )
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
      ),
    );
  }
}

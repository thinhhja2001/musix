import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_auth/entities/event/auth_event.dart';
import 'package:musix/domain_auth/payload/request/reset_password_request.dart';
import 'package:musix/domain_auth/views/screens/email_verification_screen/utils/function.dart';
import 'package:musix/domain_auth/views/screens/reset_password_screen/utils/text_path.dart';

import '../../../../routing/routing_path.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../entities/state/auth_state.dart';
import '../../../logic/auth_bloc.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_error_box.dart';
import '../../widgets/custom_textfield_widget.dart';
import 'utils/validate_password.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final ResetPasswordTextPath resetPasswordTextPath = ResetPasswordTextPath();
  final TextEditingController _resetCodeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, current) {
        return (prev.resetStatus != 200 &&
            current.resetStatus == 200 &&
            current.isResetLoading == false);
      },
      listener: (context, state) {
        showSnackBar(context,
            title: "Success",
            content: "Password changed, you can now login using new password",
            contentType: ContentType.success);
        Navigator.of(context).pushNamed(RoutingPath.signIn);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              context.read<AuthBloc>().add(AuthResetPasswordScreenBackEvent());
              return true;
            },
            child: Form(
              key: _formKey,
              child: Scaffold(
                backgroundColor: ColorTheme.background,
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      AssetPath.resetCover,
                                    ),
                                    fit: BoxFit.fill),
                              ),
                              height: double.infinity,
                              width: double.infinity,
                              child: Stack()),
                        ),
                        Flexible(flex: 2, child: Container())
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  resetPasswordTextPath.resetPasswordTitle,
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
                                      color: ColorTheme.primary,
                                      spreadRadius: 3)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      resetPasswordTextPath.instruction,
                                      style: TextStyleTheme.ts15.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      resetPasswordTextPath.warningExpiredTime,
                                      style: TextStyleTheme.ts15
                                          .copyWith(color: Colors.yellow),
                                    ),
                                    CustomInputFieldWidget(
                                      textInputType: TextInputType.text,
                                      label: resetPasswordTextPath.resetCode,
                                      controller: _resetCodeController,
                                      validation: (value) {
                                        if (value == null ||
                                            value.trim() == '') {
                                          return resetPasswordTextPath
                                              .emptyResetCode;
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomInputFieldWidget(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      label: resetPasswordTextPath.newPassword,
                                      controller: _newPasswordController,
                                      validation: (value) {
                                        return validatePassword(value);
                                      },
                                    ),
                                    CustomInputFieldWidget(
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      label: resetPasswordTextPath
                                          .confirmNewPassword,
                                      controller: _confirmPasswordController,
                                      validation: (value) {
                                        if (value == null ||
                                            value.trim() == '') {
                                          return "Please confirm your new password";
                                        }
                                        if (value !=
                                            _newPasswordController.text) {
                                          return "Confirm password does not match";
                                        }
                                        return null;
                                      },
                                    ),
                                    (state.resetStatus != null &&
                                            state.resetStatus != 200)
                                        ? CustomErrorBox(
                                            message: state.resetMsg ??
                                                "Unknown error")
                                        : Container(),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    CustomButtonWidget(
                                        isLoading: state.isResetLoading,
                                        onPress: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            String currentEmail = GetIt.I
                                                .get<String>(
                                                    instanceName:
                                                        "currentEmail");
                                            context.read<AuthBloc>().add(
                                                AuthResetPasswordEvent(
                                                    ResetPasswordRequest(
                                                        token:
                                                            _resetCodeController
                                                                .text,
                                                        email: currentEmail,
                                                        newPassword:
                                                            _newPasswordController
                                                                .text)));
                                          }
                                        },
                                        content: 'Send'),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

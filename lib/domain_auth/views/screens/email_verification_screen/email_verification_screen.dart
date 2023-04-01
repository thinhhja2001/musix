import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_auth/entities/event/auth_event.dart';
import 'package:musix/domain_auth/views/screens/email_verification_screen/utils/function.dart';
import 'package:musix/domain_auth/views/screens/email_verification_screen/utils/text_path.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_user/models/user_info/user_model.dart';
import 'package:musix/routing/routing_path.dart';

import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../entities/state/auth_state.dart';
import '../../../logic/auth_bloc.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailVerificationTextPath = EmailVerificationTextPath();
    final currentUser = GetIt.I.get<UserModel>();
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prevState, currentState) {
        return (prevState.isResendEmailLoading == true &&
            currentState.isResendEmailLoading == false);
      },
      listener: (context, state) {
        if (state.resendEmailStatus == 200) {
          showSnackBar(context,
              content: "Email sent", contentType: ContentType.success);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
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
                                  AssetPath.emailVerificationCover,
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
                              emailVerificationTextPath.emailVerificationTitle,
                              style: TextStyleTheme.ts28.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              emailVerificationTextPath
                                  .emailVerificationDescription,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButtonWidget(
                                onPress: () => Navigator.of(context)
                                    .pushNamedAndRemoveUntil(RoutingPath.home,
                                        (Route<dynamic> route) => false),
                                content: "Go to Home",
                                backgroundColor: Colors.blue,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                emailVerificationTextPath.stillNotReceive,
                                style: TextStyleTheme.ts16
                                    .copyWith(color: ColorTheme.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButtonWidget(
                                onPress: () {
                                  context.read<AuthBloc>().add(
                                      AuthResendVerificationEmailEvent(
                                          currentUser.username));
                                },
                                isLoading: state.isResendEmailLoading,
                                content: "Resend email",
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
          );
        },
      ),
    );
  }
}

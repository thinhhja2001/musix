import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:musix/domain_auth/entities/event/auth_event.dart';
import 'package:musix/domain_auth/payload/request/register_request.dart';
import 'package:musix/domain_auth/utils/functions.dart';

import '../../../../routing/routing_path.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import '../../../entities/state/auth_state.dart';
import '../../../logic/auth_bloc.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_date_picker_widget.dart';
import '../../widgets/custom_error_box.dart';
import '../../widgets/custom_textfield_widget.dart';
import 'utils/text_path.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpTextPath = SignUpTextPath();
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  DateTime? _birthDay;
  String? _errorBirthday;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.registerStatus == 200) {
          print("navigating to email verification screen");
          Navigator.of(context).pushNamed(RoutingPath.emailVerification);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Scaffold(
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
                                    AssetPath.signUpCover,
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
                                signUpTextPath.signUpTitle,
                                style: TextStyleTheme.ts28.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                signUpTextPath.signUpDescription,
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
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(children: [
                              CustomInputFieldWidget(
                                textInputType: TextInputType.text,
                                label: signUpTextPath.fullName,
                                controller: _fullNameController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signUpTextPath.emptyUserName;
                                  }
                                  return null;
                                },
                              ),
                              CustomInputFieldWidget(
                                textInputType: TextInputType.text,
                                label: signUpTextPath.userName,
                                controller: _userNameController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signUpTextPath.emptyUserName;
                                  }
                                  return null;
                                },
                              ),
                              CustomInputFieldWidget(
                                textInputType: TextInputType.text,
                                label: signUpTextPath.emailAddress,
                                controller: _emailController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signUpTextPath.emptyEmail;
                                  } else if (!EmailValidator.validate(value)) {
                                    return signUpTextPath.invalidEmail;
                                  }
                                  return null;
                                },
                              ),
                              CustomInputFieldWidget(
                                textInputType: TextInputType.visiblePassword,
                                label: signUpTextPath.password,
                                controller: _passwordController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signUpTextPath.emptyPassword;
                                  }
                                  return null;
                                },
                              ),
                              CustomInputFieldWidget(
                                textInputType: TextInputType.visiblePassword,
                                label: signUpTextPath.passwordConfirm,
                                controller: _passwordConfirmController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signUpTextPath.emptyPasswordConfirm;
                                  }
                                  if (value != _passwordController.text) {
                                    return signUpTextPath
                                        .passwordConfirmDoesNotMatch;
                                  }
                                  return null;
                                },
                              ),
                              CustomInputFieldWidget(
                                textInputType: TextInputType.phone,
                                label: signUpTextPath.phoneNumber,
                                controller: _phoneNumberController,
                                validation: (value) {
                                  if (value == null || value.isEmpty) {
                                    return signUpTextPath.emptyPhoneNumber;
                                  }
                                  if (!value.startsWith('0') ||
                                      !isNumericString(value) ||
                                      value.length != 10) {
                                    return signUpTextPath.invalidPhoneNumber;
                                  }
                                  return null;
                                },
                              ),
                              CustomDatePickerWidget(
                                label: signUpTextPath.birthday,
                                datePicker: _birthDay,
                                pickDateFunction: (value) {
                                  setState(() {
                                    if (_errorBirthday != null) {
                                      _errorBirthday = null;
                                    }
                                    _birthDay = value;
                                  });
                                },
                                error: _errorBirthday,
                              ),
                              (state.registerStatus != 200 &&
                                      state.registerStatus != null)
                                  ? CustomErrorBox(
                                      message:
                                          state.registerMsg ?? "Unknown Error",
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomButtonWidget(
                                isLoading: state.isRegisterLoading,
                                onPress: state.isRegisterLoading == true
                                    ? () {}
                                    : () async {
                                        int countError = 0;
                                        if (_birthDay == null) {
                                          setState(() {
                                            _errorBirthday =
                                                signUpTextPath.emptyBirthday;
                                          });
                                          countError++;
                                        }
                                        if (_formKey.currentState!.validate()) {
                                          if (countError == 1) {
                                            return;
                                          } else {
                                            context.read<AuthBloc>().add(
                                                AuthRegisterEvent(RegisterRequest(
                                                    username:
                                                        _userNameController
                                                            .text,
                                                    fullName:
                                                        _fullNameController
                                                            .text,
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                    birthday:
                                                        DateFormat("dd/MM/yyyy")
                                                            .format(_birthDay ??
                                                                DateTime.now()),
                                                    phoneNumber:
                                                        _phoneNumberController
                                                            .text)));
                                          }
                                        }
                                      },
                                content: signUpTextPath.createAccount,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    signUpTextPath.haveAccount,
                                    style: TextStyleTheme.ts15.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, RoutingPath.signIn);
                                    },
                                    child: Text(
                                      signUpTextPath.signIn,
                                      style: TextStyleTheme.ts15.copyWith(
                                        color: ColorTheme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ]),
                          ),
                        ),
                      ))
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

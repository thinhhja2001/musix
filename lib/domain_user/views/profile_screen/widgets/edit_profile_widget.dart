import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:musix/global/widgets/widgets.dart';

import '../../../../config/exporter.dart';
import '../../../../domain_auth/views/widgets/custom_date_picker_widget.dart';
import '../../../../domain_auth/views/widgets/custom_textfield_widget.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';
import 'change_password_widget.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _birthDay;
  String? _errorBirthday;
  String? _error;

  @override
  void initState() {
    final state = BlocProvider.of<ProfileBloc>(context).state;
    if (state.user?.profile != null) {
      _userNameController.text = state.user!.profile!.fullName!;
      _emailController.text = state.user!.email!;
      _phoneController.text = state.user!.profile!.phoneNumber!;
      if (state.user!.profile!.birthday!.contains('/')) {
        _birthDay =
            DateFormat("dd/MM/yyyy").parse(state.user!.profile!.birthday!);
      } else if (state.user!.profile!.birthday!.contains('-')) {
        _birthDay =
            DateFormat("dd-MM-yyyy").parse(state.user!.profile!.birthday!);
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: AlignmentDirectional.center,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              color: ColorTheme.backgroundDarker,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'User Info',
                      style: TextStyleTheme.ts20.copyWith(
                        color: ColorTheme.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInputFieldWidget(
                    textInputType: TextInputType.text,
                    label: 'Username',
                    controller: _userNameController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is not empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInputFieldWidget(
                    textInputType: TextInputType.text,
                    label: 'Email',
                    controller: _emailController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is not empty';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Email is not valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomInputFieldWidget(
                    textInputType: TextInputType.phone,
                    label: 'Phone Number',
                    controller: _phoneController,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number is not empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomDatePickerWidget(
                    label: 'Birthday',
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
                  const SizedBox(
                    height: 12,
                  ),
                  BlocConsumer<ProfileBloc, ProfileState>(listener: (_, state) {
                    if (state.status?[ProfileStatusKey.uploadProfile.name] ==
                        Status.loading) {
                      _error = null;
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const LoadingWidget();
                          });
                    } else if (state
                            .status?[ProfileStatusKey.uploadProfile.name] ==
                        Status.success) {
                      Navigator.maybePop(context);
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        Navigator.maybePop(context);
                        Future.delayed(const Duration(milliseconds: 300)).then(
                            (value) => Fluttertoast.showToast(
                                msg: "Update Info Success",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorTheme.primaryLighten,
                                textColor: ColorTheme.backgroundDarker,
                                fontSize: 12));
                      });
                    }
                  }, builder: (context, state) {
                    if (state.status?[ProfileStatusKey.uploadProfile.name] ==
                        Status.error) {
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        Navigator.maybePop(context);
                      });
                      _error = state.error?.message;
                    }
                    return Text(
                      _error ?? "",
                      style: TextStyleTheme.ts10.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          onPressed: () => Navigator.maybePop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorTheme.background,
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: SizedBox(
                            height: 30,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                'Back',
                                style: TextStyleTheme.ts16.copyWith(
                                  color: ColorTheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              context.read<ProfileBloc>().add(
                                    UploadProfileEvent(
                                      fullName: _userNameController.text,
                                      phoneNumber: _phoneController.text,
                                      birthday: DateFormat("dd-MM-yyyy")
                                          .format(_birthDay!),
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorTheme.primaryLighten,
                            padding: const EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: SizedBox(
                            height: 30,
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyleTheme.ts16.copyWith(
                                  color: ColorTheme.backgroundDarker,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const ChangePasswordWidget());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Center(
                        child: Text(
                          'Change Password',
                          style: TextStyleTheme.ts16.copyWith(
                            color: ColorTheme.primaryLighten,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

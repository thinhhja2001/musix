import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  String? _avatarUrl;

  @override
  void initState() {
    final state = BlocProvider.of<ProfileBloc>(context).state;
    if (state.user?.profile != null) {
      _userNameController.text = state.user!.profile!.fullName!;
      _emailController.text = state.user!.email!;
      _phoneController.text = state.user!.profile!.phoneNumber!;
      _avatarUrl = state.user?.profile?.avatarUrl;
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
      insetPadding: const EdgeInsets.only(left: 12, right: 12, bottom: 56),
      alignment: AlignmentDirectional.bottomCenter,
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          fit: StackFit.loose,
          children: [
            Form(
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
                        height: 24,
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
                                height: 40,
                                width: double.maxFinite,
                                child: Center(
                                  child: Text(
                                    'Back',
                                    style: TextStyleTheme.ts20.copyWith(
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
                                height: 40,
                                width: double.maxFinite,
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyleTheme.ts20.copyWith(
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
                              builder: (context) =>
                                  const ChangePasswordWidget());
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
            Positioned(
              top: -130,
              child: GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: CachedNetworkImage(
                      imageUrl: _avatarUrl ?? AssetPath.placeImage,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.status?[ProfileStatusKey.uploadProfile] ==
                    Status.loading) {
                  return const CircularProgressIndicator();
                } else if (state.status?[ProfileStatusKey.uploadProfile] ==
                    Status.success) {
                  debugPrint('Call success');
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    Navigator.maybePop(context);
                  });
                  return const SizedBox.shrink();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'change_password_widget.dart';
import '../../../../theme/theme.dart';

import '../../widgets.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key}) : super(key: key);

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime? _birthDay;
  String? _errorBirthday;

  @override
  void initState() {
    _userNameController.text = 'Jame Smith';
    _emailController.text = 'Hello@deeper.one';
    _birthDay = DateTime(1992, 1, 26);
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
    String imgUser =
        'https://plus.unsplash.com/premium_photo-1664303602827-655efc7415da?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80';
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.maxFinite,
              height: 560,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 450,
                      decoration: BoxDecoration(
                        color: ColorTheme.backgroundDarker,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Center(
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
                              customInputFieldType: CustomInputFieldType.text,
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
                              customInputFieldType: CustomInputFieldType.text,
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
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorTheme.background,
                                padding: const EdgeInsets.all(12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Center(
                                  child: Text(
                                    'Save',
                                    style: TextStyleTheme.ts16.copyWith(
                                      color: ColorTheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
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
                                backgroundColor: ColorTheme.primaryLighten,
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
                                      color: ColorTheme.backgroundDarker,
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
                    top: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: SizedBox(
                          width: 140,
                          height: 140,
                          child: imgUser.contains('http')
                              ? Image.network(
                                  imgUser,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  imgUser,
                                  fit: BoxFit.fill,
                                )),
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

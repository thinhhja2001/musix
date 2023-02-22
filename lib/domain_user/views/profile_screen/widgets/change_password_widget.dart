import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';

import '../../widgets.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: ColorTheme.backgroundDarker,
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
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Change Password',
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
                  customInputFieldType: CustomInputFieldType.password,
                  label: 'Old Password',
                  controller: _oldPasswordController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is not empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomInputFieldWidget(
                  customInputFieldType: CustomInputFieldType.password,
                  label: 'New Password',
                  controller: _newPasswordController,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is not empty';
                    }
                    return null;
                  },
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
                    Navigator.of(context).maybePop();
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
                        'Back',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/exporter.dart';
import '../../../../global/widgets/widgets.dart';

import '../../../../domain_auth/views/widgets/custom_textfield_widget.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  String? _error;

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
                  textInputType: TextInputType.visiblePassword,
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
                  textInputType: TextInputType.visiblePassword,
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
                  height: 12,
                ),
                BlocConsumer<ProfileBloc, ProfileState>(listener: (_, state) {
                  if (state.status?[ProfileStatusKey.changePassword.name] ==
                      Status.loading) {
                    _error = null;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingWidget();
                        });
                  } else if (state
                          .status?[ProfileStatusKey.changePassword.name] ==
                      Status.success) {
                    Navigator.maybePop(context);
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.maybePop(context);
                      Future.delayed(const Duration(milliseconds: 300)).then(
                          (value) => Fluttertoast.showToast(
                              msg: "Change Password Success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: ColorTheme.primaryLighten,
                              textColor: ColorTheme.backgroundDarker,
                              fontSize: 12));
                    });
                  }
                }, builder: (context, state) {
                  if (state.status?[ProfileStatusKey.changePassword.name] ==
                      Status.error) {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context
                          .read<ProfileBloc>()
                          .add(ChangePasswordProfileEvent(
                            _oldPasswordController.text,
                            _newPasswordController.text,
                          ));
                    }
                  },
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

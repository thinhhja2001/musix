import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_auth/views/widgets/custom_textfield_widget.dart';
import 'package:musix/theme/theme.dart';

class AddNewOwnPlaylistWidget extends StatefulWidget {
  const AddNewOwnPlaylistWidget({Key? key}) : super(key: key);

  @override
  State<AddNewOwnPlaylistWidget> createState() =>
      _AddNewOwnPlaylistWidgetState();
}

class _AddNewOwnPlaylistWidgetState extends State<AddNewOwnPlaylistWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
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
          key: formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Create New Playlist',
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
                label: 'Title',
                controller: titleController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is not empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              CustomInputFieldWidget(
                textInputType: TextInputType.text,
                label: 'Description',
                controller: descriptionController,
                maxLines: 4,
              ),
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
                        if (formKey.currentState?.validate() == true) {
                          context.read<UserMusicBloc>().add(
                                CreateOwnPlaylistEvent(
                                  title: titleController.text,
                                  sortDescription: descriptionController.text,
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
            ],
          ),
        ),
      ),
    );
  }
}

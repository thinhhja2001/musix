import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../config/exporter.dart';
import '../../../../domain_auth/views/widgets/custom_textfield_widget.dart';
import '../../../../theme/theme.dart';
import '../../../../utils/utils.dart';

import '../../../../global/widgets/loading_widget.dart';

class EditOwnPlaylistWidget extends StatefulWidget {
  final String id;
  final String title;
  final String? description;
  const EditOwnPlaylistWidget({
    Key? key,
    required this.id,
    required this.title,
    this.description,
  }) : super(key: key);

  @override
  State<EditOwnPlaylistWidget> createState() => _EditOwnPlaylistWidgetState();
}

class _EditOwnPlaylistWidgetState extends State<EditOwnPlaylistWidget> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _error;

  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description ?? "";
    super.initState();
  }

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
          child: Container(
            decoration: BoxDecoration(
              color: ColorTheme.backgroundDarker,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                BlocConsumer<UserMusicBloc, UserMusicState>(
                    listener: (_, state) {
                  if (state.status?[UserMusicStatusKey.ownPlaylist.name] ==
                      Status.loading) {
                    _error = null;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const LoadingWidget();
                        });
                  } else if (state
                          .status?[UserMusicStatusKey.ownPlaylist.name] ==
                      Status.success) {
                    context.read<OwnPlaylistBloc>().add(UpdateOwnPlaylistEvent(
                          title: titleController.text,
                          sortDescription: descriptionController.text,
                        ));
                    Navigator.maybePop(context);
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.maybePop(context);
                      Future.delayed(const Duration(milliseconds: 300)).then(
                          (value) => Fluttertoast.showToast(
                              msg: "Update Playlist Success",
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
                                  ChangeOwnPlaylistEvent(
                                    playlistId: widget.id,
                                    title: titleController.text,
                                    sortDescription: descriptionController.text,
                                  ),
                                );
                            context.read<OwnPlaylistBloc>().add(
                                  UpdateOwnPlaylistEvent(
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
      ),
    );
  }
}

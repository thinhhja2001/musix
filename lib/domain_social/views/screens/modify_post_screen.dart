import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../domain_auth/views/widgets/custom_button_widget.dart';
import '../../../domain_auth/views/widgets/custom_textfield_widget.dart';
import '../../entities/event/social_event.dart';
import '../../models/post/request/post_registry_model.dart';
import '../../../theme/color.dart';
import '../../../theme/text_style.dart';

import '../../../domain_auth/views/screens/email_verification_screen/utils/function.dart';
import '../../entities/post/post.dart';
import '../../entities/state/social_state.dart';
import '../../logic/social_bloc.dart';
import '../widgets/posts/create_post_widget/select_thumbnail_widget.dart';
import '../widgets/posts/create_post_widget/select_video_widget.dart';

class ModifyPostScreen extends StatefulWidget {
  const ModifyPostScreen({
    super.key,
    required this.post,
  });
  final Post post;
  @override
  State<ModifyPostScreen> createState() => _ModifyPostScreenState();
}

class _ModifyPostScreenState extends State<ModifyPostScreen> {
  late TextEditingController captionController;

  late TextEditingController songNameController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    captionController = TextEditingController(text: widget.post.content);
    songNameController = TextEditingController(text: widget.post.fileName);
    _addThumbnail();
    _addDataSource();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<File> _addThumbnail() async {
    var file = await DefaultCacheManager()
        .getSingleFile(widget.post.thumbnailUrl!)
        .then((res) {
      context.read<SocialBloc>().add(SocialAddPostThumbnailEvent(res));
    });
    return file;
  }

  Future<File> _addDataSource() async {
    // late PlatformFile file;
    var file = await DefaultCacheManager()
        .getSingleFile(widget.post.fileUrl!)
        .then((res) {
      context.read<SocialBloc>().add(SocialAddPostDataSourceEvent(res));
    });

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<SocialBloc>().add(SocialModifyPostBackEvent());

            return true;
          },
          child: Form(
            key: formKey,
            child: BlocListener<SocialBloc, SocialState>(
              listener: (ctx, state) {
                if (state.modifyingPostStatus == 200) {
                  showSnackBar(context,
                      content: 'Post updated, you may now go back',
                      contentType: ContentType.success,
                      title: "Success");
                  context.read<SocialBloc>().add(SocialCreatePostBackEvent());
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorTheme.backgroundDarker,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: true,
                  title: const Text("Modify Post"),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SelectThumbnailWidget(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Content",
                                    style: TextStyleTheme.ts16
                                        .copyWith(color: Colors.grey),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Please add caption to your song";
                                      }
                                      return null;
                                    },
                                    cursorColor: ColorTheme.primary,
                                    controller: captionController,
                                    style: TextStyleTheme.ts28
                                        .copyWith(color: Colors.white),
                                    maxLines: 2,
                                    maxLength: 100,
                                    decoration: InputDecoration(
                                        focusColor: ColorTheme.primary,
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: ColorTheme.primary)),
                                        counterStyle: TextStyleTheme.ts12
                                            .copyWith(color: Colors.grey),
                                        hintText: "Caption your song",
                                        hintStyle: TextStyleTheme.ts28
                                            .copyWith(color: Colors.grey)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomInputFieldWidget(
                        validation: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Song name cannot be empty";
                          }
                          return null;
                        },
                        textInputType: TextInputType.text,
                        label: "Song name",
                        maxLength: 50,
                        controller: songNameController,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const SelectVideoWidget(),
                      state.sourceData != null
                          ? TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: ColorTheme.primary,
                              ),
                              onPressed: () {
                                context
                                    .read<SocialBloc>()
                                    .add(SocialRemovePostDataSourceEvent());
                              },
                              child: Text(
                                "Remove video",
                                style: TextStyleTheme.ts14
                                    .copyWith(color: ColorTheme.primary),
                              ))
                          : Container(),
                      const Spacer(),
                      CustomButtonWidget(
                        onPress: () async {
                          if (state.sourceData == null) {
                            showSnackBar(context,
                                content: "Please provide your video",
                                title: "Error",
                                contentType: ContentType.failure);
                          }
                          if (state.createPostThumbnail == null) {
                            showSnackBar(context,
                                title: 'Error',
                                contentType: ContentType.failure,
                                content: "Please provide a thumbnail");
                          }
                          if (formKey.currentState!.validate() &&
                              state.sourceData != null) {
                            context.read<SocialBloc>().add(
                                SocialModifyPostEvent(
                                    postRegistryModel: PostRegistryModel(
                                        content: captionController.text,
                                        file: File(state.sourceData!.path),
                                        thumbnail: File(
                                            state.createPostThumbnail!.path),
                                        name: songNameController.text),
                                    postId: widget.post.id!));
                          }
                        },
                        content: "Change",
                        isLoading: state.isModifyingPost,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

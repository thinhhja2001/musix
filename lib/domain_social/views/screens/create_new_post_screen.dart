import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_auth/views/widgets/custom_textfield_widget.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';
import 'package:musix/domain_social/models/post/request/post_registry_model.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

import '../../entities/state/social_state.dart';
import '../../logic/social_bloc.dart';
import '../widgets/posts/create_post_widget/select_thumbnail_widget.dart';
import '../widgets/posts/create_post_widget/select_video_widget.dart';

class CreateNewPostScreen extends StatelessWidget {
  const CreateNewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorTheme.backgroundDarker,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            title: const Text("Create New Post"),
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
                            TextField(
                              style: TextStyleTheme.ts28
                                  .copyWith(color: Colors.white),
                              maxLines: 2,
                              maxLength: 100,
                              decoration: InputDecoration(
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
                  textInputType: TextInputType.text,
                  label: "Song name",
                  controller: TextEditingController(),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SelectVideoWidget(),
                const Spacer(),
                CustomButtonWidget(
                  onPress: () async {
                    context.read<SocialBloc>().add(
                          SocialCreatePostEvent(
                            PostRegistryModel(
                              content: "hi there",
                              name: "abcdef",
                              file: File(state.sourceData!.path!),
                              thumbnail: File(state.createPostThumbnail!.path!),
                            ),
                          ),
                        );
                  },
                  content: "Upload",
                  isLoading: state.isCreatingPost,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

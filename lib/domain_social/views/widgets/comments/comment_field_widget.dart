import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/views/widgets/comments/send_comment_button_widget.dart';
import 'package:musix/utils/utils.dart';

import '../../../../theme/theme.dart';

class CommentFieldWidget extends StatefulWidget {
  const CommentFieldWidget({
    super.key,
  });

  @override
  State<CommentFieldWidget> createState() => _CommentFieldWidgetState();
}

class _CommentFieldWidgetState extends State<CommentFieldWidget> {
  final TextEditingController textEditingController =
      GetIt.I.get<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<ProfileBloc, ProfileState, String>(
          selector: (state) {
            return state.user?.profile?.avatarUrl ?? AssetPath.userUnknowImage;
          },
          builder: (context, image) {
            return CircleAvatar(
              radius: 10,
              backgroundImage: CachedNetworkImageProvider(image),
            );
          },
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add comment",
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorTheme.primary,
                    ),
                  ),
                  hintStyle: TextStyleTheme.ts16.copyWith(
                    color: ColorTheme.white.withOpacity(.7),
                  ),
                ),
                style: TextStyleTheme.ts16.copyWith(color: ColorTheme.white),
                enabled: true,
                controller: textEditingController,
                maxLines: 1,
              )),
        ),
        SendCommentButtonWidget(textEditingController: textEditingController)
      ],
    );
  }
}

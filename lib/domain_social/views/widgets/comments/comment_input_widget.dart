import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_social/views/widgets/comments/send_comment_button_widget.dart';

import '../../../../theme/theme.dart';

class CommentInputWidget extends StatefulWidget {
  CommentInputWidget({super.key});

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  final TextEditingController textEditingController =
      GetIt.I.get<TextEditingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.backgroundDarker,
      body: Row(
        children: [
          const CircleAvatar(
            radius: 10,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: ColorTheme.primary,
                  onChanged: (_) => setState(() {}),
                  controller: textEditingController,
                  decoration: InputDecoration(
                    hintText: "Add comment",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorTheme.primary,
                      ),
                    ),
                    hintStyle: TextStyleTheme.ts14.copyWith(
                      color: ColorTheme.white.withOpacity(.7),
                    ),
                  ),
                  style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
                )),
          ),
          SendCommentButtonWidget(textEditingController: textEditingController)
        ],
      ),
    );
  }
}

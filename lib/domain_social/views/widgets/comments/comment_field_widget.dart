import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/domain_social/views/widgets/comments/send_comment_button_widget.dart';

import '../../../../theme/theme.dart';
import 'comment_input_widget.dart';

class CommentFieldWidget extends StatefulWidget {
  CommentFieldWidget({
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
        const CircleAvatar(
          radius: 10,
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () => showModalBottomSheet(
                    context: context, builder: (_) => CommentInputWidget()),
                child: TextField(
                  onChanged: (_) => setState(() {}),
                  style: TextStyleTheme.ts14.copyWith(
                    color: ColorTheme.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Add Comment",
                    hintStyle: TextStyleTheme.ts14.copyWith(
                      color: ColorTheme.white.withOpacity(.7),
                    ),
                  ),
                  enabled: false,
                  controller: textEditingController,
                ),
              )),
        ),
        SendCommentButtonWidget(textEditingController: textEditingController)
      ],
    );
  }
}

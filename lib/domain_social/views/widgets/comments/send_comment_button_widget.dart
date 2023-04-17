import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';

import '../../../../theme/theme.dart';

class SendCommentButtonWidget extends StatelessWidget {
  final bool isReply;
  const SendCommentButtonWidget({
    super.key,
    required this.textEditingController,
    this.isReply = false,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (textEditingController.text.isNotEmpty) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (isReply) {
            context.read<CommentBloc>().add(RelyCommentEvent(
                BlocProvider.of<CommentBloc>(context).state.selectedCommentId!,
                textEditingController.text));
          } else {
            context
                .read<CommentBloc>()
                .add(CreateCommentEvent(textEditingController.text));
          }

          textEditingController.clear();
        }
      },
      icon: Icon(
        Icons.send,
        color: textEditingController.text.trim().isEmpty
            ? ColorTheme.white.withOpacity(.7)
            : ColorTheme.primary,
      ),
    );
  }
}

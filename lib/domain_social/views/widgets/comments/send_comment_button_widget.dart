import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';

import '../../../../theme/theme.dart';

class SendCommentButtonWidget extends StatelessWidget {
  const SendCommentButtonWidget({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (textEditingController.text.isNotEmpty) {
          FocusManager.instance.primaryFocus?.unfocus();
          context
              .read<CommentBloc>()
              .add(CreateCommentEvent(textEditingController.text));
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

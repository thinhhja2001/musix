import 'package:flutter/material.dart';

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
        ///Implement sending logic here
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

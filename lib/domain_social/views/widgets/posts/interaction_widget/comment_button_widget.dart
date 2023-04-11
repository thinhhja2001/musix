import 'package:flutter/material.dart';

import '../../../../../theme/color.dart';
import '../../../../../theme/text_style.dart';
import '../../../../entities/post/post.dart';
import '../../../screens/view_comment_screen.dart';

class CommentButtonWidget extends StatelessWidget {
  const CommentButtonWidget({
    super.key,
    required Post post,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => const ViewCommentScreen()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorTheme.white.withOpacity(.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.comment,
                color: ColorTheme.white.withOpacity(.7),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "21.9K",
                style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

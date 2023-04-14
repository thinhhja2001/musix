import 'package:flutter/material.dart';

import '../../../../entities/post/post.dart';
import 'comment_button_widget.dart';
import 'like_button_widget.dart';
import 'share_button_widget.dart';

class InteractionListWidget extends StatelessWidget {
  const InteractionListWidget({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LikeButtonWidget(postId: post.id!),
        CommentButtonWidget(post: post),
        ShareButtonWidget(post: post)
      ],
    );
  }
}

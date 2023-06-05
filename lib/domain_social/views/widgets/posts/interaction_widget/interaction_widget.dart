import 'package:flutter/material.dart';

import '../../../../entities/post/post.dart';
import 'comment_button_widget.dart';
import 'like_button_widget.dart';
import 'share_button_widget.dart';

class InteractionListWidget extends StatelessWidget {
  const InteractionListWidget(
      {super.key, required this.post, this.isPostDetail = false});
  final Post post;

  /// Whether it is being rendered in PostDetailScreen
  final bool isPostDetail;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LikeButtonWidget(postId: post.id!, isPostDetail: isPostDetail),
        CommentButtonWidget(post: post, isPostDetail: isPostDetail),
        ShareButtonWidget(post: post, isPostDetail: isPostDetail)
      ],
    );
  }
}

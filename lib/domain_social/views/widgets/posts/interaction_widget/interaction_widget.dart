import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/config/exporter/state_exporter.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';
import 'package:musix/domain_social/views/screens/view_comment_screen.dart';

import '../../../../../theme/theme.dart';
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

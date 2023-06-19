import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';

import '../../../../../theme/color.dart';
import '../../../../../theme/text_style.dart';
import '../../../../entities/post/post.dart';
import '../../../screens/view_comment_screen.dart';

class CommentButtonWidget extends StatelessWidget {
  final Post post;
  const CommentButtonWidget(
      {super.key, required this.post, this.isPostDetail = false});

  /// Whether it is being rendered in PostDetailScreen
  final bool isPostDetail;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CommentBloc>().add(GetCommentsEvent(
              postId: post.id!,
              comments: post.comments ?? [],
            ));
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (_) => const ViewCommentScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isPostDetail ? null : ColorTheme.white.withOpacity(.2),
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
                "${post.comments?.length}",
                style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

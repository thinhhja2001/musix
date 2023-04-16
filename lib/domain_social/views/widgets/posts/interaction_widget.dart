import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/domain_social/views/screens/view_comment_screen.dart';

import '../../../../config/exporter.dart';
import '../../../../theme/theme.dart';

class PostInheritedWidget extends InheritedWidget {
  final Post? post;

  const PostInheritedWidget({
    super.key,
    required this.post,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant PostInheritedWidget oldWidget) {
    return post != null && oldWidget.post != post;
  }

  static PostInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PostInheritedWidget>();
  }
}

class InteractionListWidget extends StatelessWidget {
  const InteractionListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _LikeButtonWidget(),
        _CommentButtonWidget(),
        _ShareButtonWidget()
      ],
    );
  }
}

class _LikeButtonWidget extends StatelessWidget {
  const _LikeButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icons.thumb_up,
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
    );
  }
}

class _CommentButtonWidget extends StatelessWidget {
  const _CommentButtonWidget();

  @override
  Widget build(BuildContext context) {
    final post = PostInheritedWidget.of(context)?.post;
    return InkWell(
      onTap: post != null
          ? () {
              context.read<CommentBloc>().add(GetCommentsEvent(
                    postId: post.id!,
                    comments: post.comments ?? [],
                  ));
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => const ViewCommentScreen());
            }
          : null,
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
                "${post?.comments?.length ?? 0}",
                style: TextStyleTheme.ts14.copyWith(color: ColorTheme.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareButtonWidget extends StatelessWidget {
  const _ShareButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icons.share,
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
    );
  }
}

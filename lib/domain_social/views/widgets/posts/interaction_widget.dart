import 'package:flutter/material.dart';
import 'package:musix/domain_social/views/screens/view_comment_screen.dart';

import '../../../../routing/routing_path.dart';
import '../../../../theme/theme.dart';

class InteractionListWidget extends StatelessWidget {
  const InteractionListWidget({super.key});

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

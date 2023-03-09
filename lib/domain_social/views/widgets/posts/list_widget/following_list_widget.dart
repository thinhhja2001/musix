import 'package:flutter/material.dart';

import '../post_card_widget.dart';

class FollowingListWidget extends StatelessWidget {
  const FollowingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 24,
        );
      },
      itemCount: 5,
      itemBuilder: (context, index) {
        return const PostCardWidget();
      },
    );
  }
}

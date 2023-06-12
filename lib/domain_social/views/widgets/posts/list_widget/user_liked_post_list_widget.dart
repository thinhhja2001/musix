import 'package:flutter/material.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/theme/color.dart';

import '../interaction_widget/user_info_card_widget.dart';

class UserLikedPostListWidget extends StatelessWidget {
  const UserLikedPostListWidget({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    final usersLiked = post.likedBy;
    return Container(
      color: ColorTheme.backgroundDarker,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: usersLiked?.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserInfoCardWidget(userId: post.likedBy!.elementAt(index).id!),
        ),
      ),
    );
  }
}

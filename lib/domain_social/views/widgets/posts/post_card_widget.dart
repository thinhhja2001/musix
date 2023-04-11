import 'package:flutter/material.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/domain_social/views/widgets/posts/social_data_player_widget.dart';
import 'package:musix/domain_user/utils/constant_utils.dart';
import 'package:musix/utils/functions/function_utils.dart';

import '../../../../routing/routing_path.dart';
import '../../../../theme/theme.dart';
import 'hashtag_widget.dart';
import 'interaction_widget.dart';
import 'more_list_widget/modify_post_action_widget.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
    required this.post,
  });
  final Post post;
  @override
  Widget build(BuildContext context) {
    final user = post.user;
    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorTheme.primary,
                borderRadius: BorderRadius.circular(20)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SocialDataPlayerWidget(
                      thumbnailUrl: post.thumbnailUrl!,
                      dataUrl: post.fileUrl!,
                      artistName: user?.username ?? "Unknown",
                      title: post.fileName!,
                    ),
                  ),
                ),
                Expanded(
                    child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                user!.profile!.avatarUrl ?? defaultAvatarUrl,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.username ?? "",
                                  style: TextStyleTheme.ts18.copyWith(
                                      color: ColorTheme.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  readTimestamp(post.dateCreated!),
                                  style: TextStyleTheme.ts14.copyWith(
                                    color: ColorTheme.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                _showMoreListWidget(context, post: post);
                              },
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        //Title
                        Text(
                          post.content ?? "",
                          maxLines: 2,
                          style: TextStyleTheme.ts16
                              .copyWith(color: ColorTheme.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const HashtagWidget(),
                        const Spacer(),
                        InteractionListWidget(post: post),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> _showMoreListWidget(
    BuildContext context, {
    required Post post,
  }) {
    return showModalBottomSheet(
        backgroundColor: ColorTheme.backgroundDarker,
        context: context,
        builder: (ctx) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, __) => ModifyPostActionWidget(
                    icon: Icons.edit,
                    text: "Modify Post",
                    onTap: () => Navigator.of(context)
                        .pushNamed(RoutingPath.modifyPost, arguments: post),
                  ),
              separatorBuilder: (_, __) => const SizedBox(height: 5),
              itemCount: 1);
        });
  }
}

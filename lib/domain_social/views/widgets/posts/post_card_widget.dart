import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/utils/functions/function_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';
import 'hashtag_widget.dart';
import 'interaction_widget.dart';

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
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            width: double.infinity,
                            placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: ColorTheme.background,
                                  highlightColor: ColorTheme.backgroundDarker,
                                  child: const Material(
                                    color: Colors.white,
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 240,
                                    ),
                                  ),
                                ),
                            fit: BoxFit.fill,
                            imageUrl: post.thumbnailUrl ?? ""),
                      ),
                    ],
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
                                user!.profile!.avatarUrl ??
                                    "https://res.cloudinary.com/musix-cloud/image/upload/v1680776471/default_avatar_asqchd.png",
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
                        const InteractionListWidget(),
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
}

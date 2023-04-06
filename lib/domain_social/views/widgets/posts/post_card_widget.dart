import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/domain_social/views/widgets/posts/social_video_player_widget.dart';
import 'package:musix/domain_user/utils/constant_utils.dart';
import 'package:musix/domain_video/entities/video_detail.dart';
import 'package:musix/domain_video/utils/methods.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_player_widget.dart';
import 'package:musix/utils/functions/function_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

import '../../../../theme/theme.dart';
import '../../../utils/custom_social_media_control.dart';
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
    Future<ChewieController> buildChewieController() async {
      VideoPlayerController videoPlayerController =
          VideoPlayerController.network(post.fileUrl!);
      await videoPlayerController.initialize();
      return ChewieController(
          videoPlayerController: videoPlayerController,
          showControls: true,
          customControls: CustomSocialMediaControl(
            title: post.fileName!,
            singer: post.user!.username!,
          ),
          materialProgressColors: ChewieProgressColors(
            playedColor: ColorTheme.primary,
            bufferedColor: Colors.grey,
            backgroundColor: Colors.white,
          ),
          allowFullScreen: true);
    }

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
                  child: FutureBuilder<ChewieController>(
                      future: buildChewieController(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SocialVideoPlayerWidget(
                                  controller: snapshot.data!));
                        }
                        return Container();
                      }),
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

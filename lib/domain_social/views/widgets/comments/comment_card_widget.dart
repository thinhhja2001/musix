import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';

class CommentCardWidget extends StatelessWidget {
  final Comment comment;
  const CommentCardWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 10,
            child: CachedNetworkImage(
              imageUrl:
                  comment.user?.profile?.avatarUrl ?? AssetPath.placeImage,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: ColorTheme.background,
                highlightColor: ColorTheme.backgroundDarker,
                child: Material(
                  color: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${comment.user?.profile?.fullName ?? "Anonymous"} · ${convertMillisecondToDateString(comment.dateCreated ?? DateTime.now().millisecondsSinceEpoch)}",
                    style: TextStyleTheme.ts12
                        .copyWith(color: ColorTheme.white.withOpacity(.7)),
                  ),
                  Text(
                    "${comment.content}",
                    style: TextStyleTheme.ts12.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.thumb_up_alt,
                        color: ColorTheme.white,
                        size: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "${comment.likeCount ?? 0}",
                          style: TextStyleTheme.ts10
                              .copyWith(color: ColorTheme.white),
                        ),
                      ),
                      // const Icon(
                      //   Icons.thumb_down_off_alt_outlined,
                      //   color: ColorTheme.white,
                      //   size: 10,
                      // ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.comment_outlined,
                        size: 10,
                        color: ColorTheme.white,
                      )
                    ],
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   style: ButtonStyle(
                  //     overlayColor: MaterialStatePropertyAll(
                  //       ColorTheme.primary.withOpacity(.2),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     "15 replies",
                  //     style: TextStyleTheme.ts14
                  //         .copyWith(color: ColorTheme.primary),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}

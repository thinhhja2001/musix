import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter.dart';
import 'package:musix/domain_social/entities/entities.dart';
import 'package:musix/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';
import 'edit_comment_widget.dart';

class CommentCardWidget extends StatelessWidget {
  final Comment comment;
  const CommentCardWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
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
                    style: TextStyleTheme.ts14
                        .copyWith(color: ColorTheme.white.withOpacity(.7)),
                  ),
                  Text(
                    "${comment.content}",
                    style: TextStyleTheme.ts14.copyWith(
                      color: ColorTheme.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<CommentBloc>()
                              .add(LikeCommentEvent(comment.id!));
                        },
                        child: BlocSelector<ProfileBloc, ProfileState, bool>(
                          selector: (state) {
                            try {
                              var user = comment.likedBy?.firstWhere(
                                  (element) => element.id == state.user?.id);
                              if (user != null) {
                                return true;
                              } else {
                                return false;
                              }
                            } on StateError {
                              return false;
                            }
                          },
                          builder: (context, isLiked) {
                            return Icon(
                              Icons.thumb_up_alt,
                              color: isLiked
                                  ? ColorTheme.primary
                                  : ColorTheme.white,
                              size: 12,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          "${comment.likeCount ?? 0}",
                          style: TextStyleTheme.ts12
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
                        size: 12,
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
                  // ),
                ],
              ),
            ),
          ),
          PopupMenuButton(
            color: ColorTheme.background,
            offset: const Offset(-32, -8),
            child: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == 0) {
                showDialog(
                    context: context,
                    builder: (context) => EditCommentWidget(comment: comment));
              } else if (value == 1) {
                context
                    .read<CommentBloc>()
                    .add(DeleteCommentEvent(comment.id!));
              }
            },
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Center(
                    child: Text(
                      "Edit",
                      style: TextStyleTheme.ts14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Center(
                    child: Text(
                      "Delete",
                      style: TextStyleTheme.ts14.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}

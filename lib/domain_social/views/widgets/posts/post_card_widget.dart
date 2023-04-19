import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain_auth/views/screens/email_verification_screen/utils/function.dart';
import '../../../entities/event/social_event.dart';
import '../../../entities/post/post.dart';
import '../../../logic/social_bloc.dart';
import 'social_data_player_widget.dart';
import '../../../../domain_user/utils/constant_utils.dart';
import '../../../../utils/functions/function_utils.dart';

import '../../../../domain_user/entities/profile/profile_state.dart';
import '../../../../domain_user/logic/profile_bloc.dart';
import '../../../../routing/routing_path.dart';
import '../../../../theme/theme.dart';
import 'hashtag_widget.dart';
import 'interaction_widget/interaction_widget.dart';
import 'more_list_widget/post_action_widget.dart';

class PostCardWidget extends StatefulWidget {
  const PostCardWidget({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool isHide = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.post.user;
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
                      thumbnailUrl: widget.post.thumbnailUrl!,
                      dataUrl: widget.post.fileUrl!,
                      artistName: user?.username ?? "Unknown",
                      title: widget.post.fileName!,
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
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RoutingPath.profileSocial,
                                arguments: user,
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  user!.profile!.avatarUrl ?? defaultAvatarUrl,
                                ),
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
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    RoutingPath.profileSocial,
                                    arguments: user,
                                  ),
                                  child: Text(
                                    user.username ?? "",
                                    style: TextStyleTheme.ts18.copyWith(
                                        color: ColorTheme.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  readTimestamp(widget.post.dateCreated!),
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
                                _showMoreListWidget(context, post: widget.post);
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
                          widget.post.content ?? "",
                          maxLines: 2,
                          style: TextStyleTheme.ts16
                              .copyWith(color: ColorTheme.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const HashtagWidget(),
                        const Spacer(),
                        InteractionListWidget(post: widget.post),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: ColorTheme.backgroundDarker,
        context: context,
        builder: (ctx) {
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorTheme.background),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      post.user == state.user
                          ? PostActionWidget(
                              icon: Icons.edit,
                              text: "Modify Post",
                              onTap: () => Navigator.of(context).pushNamed(
                                  RoutingPath.modifyPost,
                                  arguments: post),
                            )
                          : Container(),
                      post.user == state.user
                          ? PostActionWidget(
                              icon: Icons.delete,
                              text: "Delete Post",
                              onTap: () => _buildAlertDialog(context, post),
                            )
                          : Container(),
                      const PostActionWidget(
                          text: 'Save Post', icon: Icons.bookmark_border)
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> _buildAlertDialog(BuildContext context, Post post) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorTheme.background,
          title: Text(
            'Are you want to delete?',
            style: TextStyleTheme.ts22.copyWith(color: Colors.white),
          ),
          content: Text(
            'This action cannot be undone',
            style: TextStyleTheme.ts20.copyWith(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Cancel',
                style: TextStyleTheme.ts16.copyWith(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Delete',
                style: TextStyleTheme.ts16.copyWith(color: Colors.red),
              ),
              onPressed: () {
                context.read<SocialBloc>().add(SocialDeletePostEvent(post));
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

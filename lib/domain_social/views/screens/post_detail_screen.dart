import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/config/exporter/repo_exporter.dart';
import 'package:musix/domain_social/entities/post/post.dart';
import 'package:musix/domain_social/views/widgets/posts/interaction_widget/interaction_widget.dart';
import 'package:musix/domain_social/views/widgets/posts/more_list_widget/post_action_widget.dart';
import 'package:musix/domain_social/views/widgets/posts/post_shimmer_loading_widget.dart';
import 'package:musix/domain_social/views/widgets/posts/social_data_player_widget.dart';
import 'package:musix/domain_user/utils/constant_utils.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';
import 'package:musix/utils/functions/function_utils.dart';

import '../../../config/exporter/bloc_exporter.dart';
import '../../../config/exporter/state_exporter.dart';
import '../../entities/utils/social_mapper.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) {
    Future<Post> getPostById(String postId) async {
      final String token = context.read<AuthBloc>().state.jwtToken!;
      final postRepo = GetIt.I.get<PostRepo>();
      final postModel = await postRepo.getPostById(postId, token);
      return await SocialMapper(token).postFromPostModel(postModel!);
    }

    return Scaffold(
        backgroundColor: ColorTheme.backgroundDarker,
        body: SafeArea(
          child: FutureBuilder<Post>(
              future: getPostById(postId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final post = snapshot.data;
                  final user = post!.user;
                  return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () => Navigator.pushNamed(
                                                context,
                                                RoutingPath.profileSocial,
                                                arguments: user,
                                              ),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                  user!.profile!.avatarUrl ??
                                                      defaultAvatarUrl,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8.0,
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                    context,
                                                    RoutingPath.profileSocial,
                                                    arguments: user,
                                                  ),
                                                  child: Text(
                                                    user.username ?? "",
                                                    style: TextStyleTheme.ts18
                                                        .copyWith(
                                                            color: ColorTheme
                                                                .white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ),
                                                Text(
                                                  readTimestamp(
                                                      post.dateCreated!),
                                                  style: TextStyleTheme.ts14
                                                      .copyWith(
                                                    color: ColorTheme.white,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                _showMoreListWidget(context,
                                                    post: post);
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
                                          style: TextStyleTheme.ts16.copyWith(
                                              color: ColorTheme.white),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Spacer(),
                                        InteractionListWidget(
                                            post: snapshot.data!,
                                            isPostDetail: true),
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          )
                        ],
                      ));
                }
                return PostShimmerLoadingWidget(
                  height: MediaQuery.of(context).size.height * 2 / 3,
                );
              }),
        ));
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

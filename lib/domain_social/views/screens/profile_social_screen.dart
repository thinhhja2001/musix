import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/domain_auth/views/widgets/custom_button_widget.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';
import 'package:musix/domain_social/views/widgets/posts/social_data_player_widget.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';
import 'package:musix/utils/functions/function_utils.dart';
import 'package:provider/provider.dart';

import '../../../domain_user/entities/user.dart';
import '../../../domain_user/utils/constant_utils.dart';
import '../../entities/state/social_state.dart';

class ProfileSocialScreen extends StatefulWidget {
  const ProfileSocialScreen({super.key, required this.user});
  final User user;

  @override
  State<ProfileSocialScreen> createState() => _ProfileSocialScreenState();
}

class _ProfileSocialScreenState extends State<ProfileSocialScreen> {
  late ScrollController scrollController;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    context
        .read<SocialBloc>()
        .add(SocialLoadUserPostEvent(widget.user.username!));
    scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients || _loading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loading = true;
      context
          .read<SocialBloc>()
          .add(SocialLoadUserPostEvent(widget.user.username!));
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.profile?.fullName}"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              context.read<SocialBloc>().add(SocialProfileBackEvent());

              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: ColorTheme.backgroundDarker,
      body: BlocBuilder<SocialBloc, SocialState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              context.read<SocialBloc>().add(SocialProfileBackEvent());

              return true;
            },
            child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            widget.user.profile!.avatarUrl ?? defaultAvatarUrl),
                      ),
                      Text(
                        "@${widget.user.username}",
                        style:
                            TextStyleTheme.ts18.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${widget.user.followings?.length}',
                                style: TextStyleTheme.ts14.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Following",
                                style: TextStyleTheme.ts12
                                    .copyWith(color: const Color(0xff86878B)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${widget.user.followings?.length}',
                                style: TextStyleTheme.ts14.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyleTheme.ts12
                                    .copyWith(color: const Color(0xff86878B)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '46K',
                                style: TextStyleTheme.ts14.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Likes",
                                style: TextStyleTheme.ts12
                                    .copyWith(color: const Color(0xff86878B)),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomButtonWidget(
                                  onPress: () {}, content: "Follow"),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey)),
                                  child: const Icon(
                                    FontAwesomeIcons.instagram,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.grey)),
                                  child: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Never lose hope \nAdditional profile information",
                        style:
                            TextStyleTheme.ts16.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                state.userPosts != null
                    ? SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemCount: state.userPosts?.length,
                        itemBuilder: (context, index) {
                          final post = state.userPosts!.elementAt(index);
                          return SocialDataPlayerWidget(
                            dataUrl: post.fileUrl!,
                            title: post.fileName!,
                            artistName: post.user!.username!,
                            thumbnailUrl: post.thumbnailUrl!,
                          );
                        })
                    : SliverGrid.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemCount: 4,
                        itemBuilder: (context, index) =>
                            shimmerLoadingEffect(width: 100))
              ],
            ),
          );
        },
      ),
    );
  }
}

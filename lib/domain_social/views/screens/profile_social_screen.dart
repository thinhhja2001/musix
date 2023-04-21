import 'package:flutter/material.dart';
import 'package:flutter/src/material/refresh_indicator.dart' as ri;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';
import 'package:musix/domain_social/views/widgets/posts/post_shimmer_loading_widget.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain_user/entities/user.dart';
import '../../../domain_user/utils/constant_utils.dart';
import '../../entities/state/social_state.dart';
import '../widgets/posts/post_card_widget.dart';
import '../widgets/profile_social/follow_information_widget.dart';
import '../widgets/profile_social/interact_with_user_widget.dart';

class ProfileSocialScreen extends StatefulWidget {
  const ProfileSocialScreen({super.key, required this.user});
  final User user;

  @override
  State<ProfileSocialScreen> createState() => _ProfileSocialScreenState();
}

class _ProfileSocialScreenState extends State<ProfileSocialScreen> {
  late ScrollController scrollController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
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

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
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
      body: ri.RefreshIndicator(
        onRefresh: () async {
          Future.delayed(Duration(seconds: 3));
          print("calling setstate");
          setState(() {});
        },
        backgroundColor: ColorTheme.background,
        color: ColorTheme.primary,
        child: BlocBuilder<SocialBloc, SocialState>(
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
                              widget.user.profile!.avatarUrl ??
                                  defaultAvatarUrl),
                        ),
                        Text(
                          "@${widget.user.username}",
                          style:
                              TextStyleTheme.ts18.copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FollowInformationWidget(user: widget.user),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: InteractWithUserWidget(user: widget.user),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Never lose hope \nAdditional profile information",
                          textAlign: TextAlign.center,
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
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PostCardWidget(
                                      post: state.userPosts!.elementAt(index),
                                    ),
                                  ),
                              childCount: state.userPosts?.length),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  const PostShimmerLoadingWidget(),
                              childCount: 2),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';

import '../../../../entities/state/social_state.dart';
import '../../../../logic/social_bloc.dart';
import '../post_card_widget.dart';
import '../post_shimmer_loading_widget.dart';

class FollowingListWidget extends StatefulWidget {
  const FollowingListWidget({super.key});
  @override
  State<FollowingListWidget> createState() => _FollowingListWidgetState();
}

class _FollowingListWidgetState extends State<FollowingListWidget> {
  late ScrollController scrollController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(SocialGetListPostFollowingEvent());

    scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients || _loading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loading = true;
      context.read<SocialBloc>().add(SocialFollowingPostLoadMoreEvent());
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return state.followingPosts != null
            ? ListView.separated(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
                itemCount: state.followingPosts!.length,
                itemBuilder: (context, index) {
                  return PostCardWidget(
                    post: state.followingPosts!.elementAt(index),
                  );
                },
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const PostShimmerLoadingWidget(
                    padding: EdgeInsets.all(8.0),
                  );
                },
              );
      },
    );
  }
}

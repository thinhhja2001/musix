import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';

import '../../../../entities/state/social_state.dart';
import '../../../../logic/social_bloc.dart';
import '../post_card_widget.dart';
import '../post_shimmer_loading_widget.dart';

class JustForYouListWidget extends StatefulWidget {
  const JustForYouListWidget({super.key});

  @override
  State<JustForYouListWidget> createState() => _JustForYouListWidgetState();
}

class _JustForYouListWidgetState extends State<JustForYouListWidget>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(SocialGetListPostJustForYouEvent());

    scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients || _loading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loading = true;
      context.read<SocialBloc>().add(SocialJust4YouPostLoadMoreEvent());
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SocialBloc, SocialState>(
      buildWhen: (previous, current) {
        if (previous.justForYouPosts?.length !=
            current.justForYouPosts?.length) {}
        return previous.justForYouPosts?.length !=
            current.justForYouPosts?.length;
      },
      builder: (context, state) {
        return state.justForYouPosts != null
            ? ListView.separated(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
                itemCount: state.justForYouPosts!.length,
                itemBuilder: (context, index) {
                  return PostCardWidget(
                      post: state.justForYouPosts!.elementAt(index));
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

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../entities/event/social_event.dart';
import '../../../../entities/state/social_state.dart';
import '../../../../logic/social_bloc.dart';
import '../post_card_widget.dart';
import '../post_shimmer_loading_widget.dart';

class TrendingListWidget extends StatefulWidget {
  const TrendingListWidget({super.key});

  @override
  State<TrendingListWidget> createState() => _TrendingListWidgetState();
}

class _TrendingListWidgetState extends State<TrendingListWidget>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scrollController;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(SocialGetListPostTrendingEvent());

    scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onScroll() {
    if (!scrollController.hasClients || _loading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _loading = true;
      context.read<SocialBloc>().add(SocialGetListPostTrendingEvent());
      _loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return state.trendingPosts != null
            ? ListView.separated(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
                itemCount: state.trendingPosts!.length,
                itemBuilder: (context, index) {
                  return PostCardWidget(
                      post: state.trendingPosts!.elementAt(index));
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

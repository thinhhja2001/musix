import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/exporter/bloc_exporter.dart';
import 'package:musix/domain_global/views/home_screen/widgets/search_bar_navigator_widget.dart';
import 'package:musix/domain_social/entities/event/social_event.dart';
import 'package:musix/domain_social/views/widgets/posts/list_widget/following_list_widget.dart';
import 'package:musix/domain_social/views/widgets/posts/list_widget/trending_list_widget.dart';
import 'package:musix/theme/theme.dart';

import '../widgets/posts/list_widget/just_for_you_list_widget.dart';
import '../widgets/story_list_widget.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SocialBloc>().add(SocialGetListPostJustForYouEvent());
    context.read<SocialBloc>().add(SocialGetListPostTrendingEvent());
    context.read<SocialBloc>().add(SocialGetListPostFollowingEvent());
    return Scaffold(
      backgroundColor: ColorTheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                    child: SearchBarNavigationWidget(
                        hintText: "What do you want to hear")),
                // CircleAvatar(
                //   radius: 30,
                //   backgroundImage: NetworkImage(
                //       "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                // ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const StoryListWidget(),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      indicatorColor: Colors.transparent,
                      labelColor: ColorTheme.primary,
                      labelStyle: TextStyleTheme.ts18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.primary),
                      unselectedLabelStyle: TextStyleTheme.ts14,
                      labelPadding: const EdgeInsets.only(bottom: 8.0),
                      unselectedLabelColor: ColorTheme.white.withOpacity(.7),
                      tabs: const [
                        Text("Just for you"),
                        Text(
                          "Trending",
                        ),
                        Text("Following")
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          JustForYouListWidget(),
                          TrendingListWidget(),
                          FollowingListWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

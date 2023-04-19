import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/routing/routing_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/exporter/bloc_exporter.dart';
import '../../../domain_auth/views/screens/email_verification_screen/utils/function.dart';
import '../../../theme/theme.dart';
import '../../entities/state/social_state.dart';
import '../widgets/posts/create_post_widget/create_post_widget.dart';
import '../widgets/posts/list_widget/following_list_widget.dart';
import '../widgets/posts/list_widget/just_for_you_list_widget.dart';
import '../widgets/posts/list_widget/trending_list_widget.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialBloc, SocialState>(
      listener: (context, state) {
        if (state.deletePostStatus == 200) {
          showSnackBar(context,
              content: "Success",
              contentType: ContentType.success,
              title: "Post deleted");
        } else if (state.deletePostStatus != null &&
            state.deletePostStatus != 200) {
          showSnackBar(context,
              content: "Error",
              contentType: ContentType.failure,
              title: "Error deleting post");
        }
      },
      child: Scaffold(
        backgroundColor: ColorTheme.background,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SvgPicture.asset(
                      "assets/images/icons/musiX.svg",
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Shimmer.fromColors(
                      baseColor: ColorTheme.white,
                      highlightColor: ColorTheme.primary,
                      child: Text(
                        "Musix",
                        style: TextStyleTheme.ts18.copyWith(
                            fontFamily: "NotoMusic",
                            color: ColorTheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RoutingPath.searchSocial);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: ColorTheme.white,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const CreatePostBarWidget(),
              const SizedBox(
                height: 10,
              ),
              // const StoryListWidget(),
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
      ),
    );
  }
}

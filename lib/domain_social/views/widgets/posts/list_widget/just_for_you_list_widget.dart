import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/color.dart';
import '../../../../entities/state/social_state.dart';
import '../../../../logic/social_bloc.dart';
import '../post_card_widget.dart';
import '../post_shimmer_loading_widget.dart';

class JustForYouListWidget extends StatelessWidget {
  const JustForYouListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      buildWhen: (previous, current) {
        if (previous.justForYouPosts?.length !=
            current.justForYouPosts?.length) {
          print("build now");
        }
        return previous.justForYouPosts?.length !=
            current.justForYouPosts?.length;
      },
      builder: (context, state) {
        return state.justForYouPosts != null
            ? ListView.separated(
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
}

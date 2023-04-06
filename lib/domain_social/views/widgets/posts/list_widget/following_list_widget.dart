import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/color.dart';
import '../../../../entities/state/social_state.dart';
import '../../../../logic/social_bloc.dart';
import '../post_card_widget.dart';

class FollowingListWidget extends StatelessWidget {
  const FollowingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return state.followingPosts != null
            ? ListView.separated(
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
            : const CircularProgressIndicator(
                color: ColorTheme.primary,
              );
      },
    );
  }
}

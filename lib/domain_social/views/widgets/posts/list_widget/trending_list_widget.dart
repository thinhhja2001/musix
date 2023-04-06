import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/color.dart';
import '../../../../entities/state/social_state.dart';
import '../../../../logic/social_bloc.dart';
import '../post_card_widget.dart';

class TrendingListWidget extends StatelessWidget {
  const TrendingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        return state.trendingPosts != null
            ? ListView.separated(
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
            : const CircularProgressIndicator(
                color: ColorTheme.primary,
              );
      },
    );
  }
}

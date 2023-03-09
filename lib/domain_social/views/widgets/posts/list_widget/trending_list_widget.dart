import 'package:flutter/material.dart';

import '../post_card_widget.dart';

class TrendingListWidget extends StatelessWidget {
  const TrendingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 24,
        );
      },
      itemCount: 5,
      itemBuilder: (context, index) {
        return const PostCardWidget();
      },
    );
  }
}

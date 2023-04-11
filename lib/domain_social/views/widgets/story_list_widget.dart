import 'package:flutter/material.dart';

import 'story_widget.dart';

class StoryListWidget extends StatelessWidget {
  const StoryListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) => const StoryWidget(),
            ),
          )
        ],
      ),
    );
  }
}

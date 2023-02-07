import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';

class WeeklySongWidget extends StatelessWidget {
  const WeeklySongWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url =
        'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
    return Row(
      children: [
        const RotatedTextWidget(text: 'Weekly'),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          alignment: Alignment.center,
          child: VideoPlayerWidget(
            videoUrl: url,
          ),
        ))
      ],
    );
  }
}

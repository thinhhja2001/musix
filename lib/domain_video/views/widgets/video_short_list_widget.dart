import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_short_card_widget.dart';

import '../../../global/widgets/widgets.dart';
import '../../models/models.dart';
import '../../utils/convert_video.dart';

class VideoShortListWidget extends StatelessWidget {
  const VideoShortListWidget({
    super.key,
    required this.title,
    required this.videos,
  });
  final String title;
  final List<VideoShortModel> videos;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        Expanded(
          child: CarouselSlider(
            items: List.generate(
              videos.length,
              (index) => VideoShortCardWidget(
                videoShort: convertVideoShortModel(
                  videos.elementAt(index),
                ),
              ),
            ),
            options: CarouselOptions(
              height: 250,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              aspectRatio: 1,
              viewportFraction: 0.64,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
            ),
          ),
        )
      ],
    );
  }
}

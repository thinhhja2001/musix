import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musix/domain_video/views/widgets/video_player/video_short_card_widget.dart';

import '../../../global/widgets/widgets.dart';
import '../../entities/video_short.dart';

enum VideoShortListType { carousel, list }

class VideoShortListWidget extends StatelessWidget {
  const VideoShortListWidget(
      {super.key,
      required this.title,
      required this.videos,
      required this.videoShortListType,
      this.onScroll});
  final String title;
  final List<VideoShort> videos;
  final VideoShortListType videoShortListType;
  final VoidCallback? onScroll;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RotatedTextWidget(text: title),
        if (videoShortListType == VideoShortListType.carousel)
          _CarouselVideoShortList(videos: videos)
        else
          ColumnVideoShortList(
            videos: videos,
            onScroll: onScroll,
          )
      ],
    );
  }
}

class ColumnVideoShortList extends StatefulWidget {
  const ColumnVideoShortList({
    super.key,
    required this.videos,
    this.onScroll,
  });
  final VoidCallback? onScroll;
  final List<VideoShort> videos;
  @override
  State<ColumnVideoShortList> createState() => _ColumnVideoShortListState();
}

class _ColumnVideoShortListState extends State<ColumnVideoShortList> {
  late ScrollController controller;
  bool _loading = false;

  void _onScroll() {
    if (controller.position.maxScrollExtent == controller.offset) {
      _loading = true;
      widget.onScroll?.call();
      Future.delayed(const Duration(seconds: 2), () => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller,
        child: Column(
          children: List.generate(
              widget.videos.length,
              (index) => VideoShortCardWidget(
                  videoShort: widget.videos.elementAt(index))),
        ),
      ),
    );
  }
}

class _CarouselVideoShortList extends StatelessWidget {
  const _CarouselVideoShortList({
    required this.videos,
  });

  final List<VideoShort> videos;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        items: List.generate(
          videos.length,
          (index) => VideoShortCardWidget(
            videoShort: videos.elementAt(index),
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
    );
  }
}

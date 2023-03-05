import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_hub/entities/entities.dart';
import '../../../global/widgets/rotated_text_widget.dart';
import '../../../theme/theme.dart';
import '../../entities/entities.dart';
import '../../logic/song_bloc.dart';
import '../widgets.dart';

enum SongArrange {
  info,
  carousel,
}

class SongListWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final bool isShowTitle;
  final SectionSong sectionSong;
  final SongArrange songArrange;
  final VoidCallback? onScroll;

  const SongListWidget({
    Key? key,
    this.isVerticalTitle = true,
    this.isScrollable = false,
    this.isShowIndex = false,
    this.isShowType = false,
    this.isShowTitle = true,
    required this.sectionSong,
    required this.songArrange,
    this.onScroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sectionSong.items?.isEmpty == true) {
      return const SizedBox.shrink();
    }
    switch (songArrange) {
      case SongArrange.info:
        return SongInfoWidget(
          sectionSong: sectionSong,
          isVerticalTitle: isVerticalTitle,
          isShowType: isShowType,
          isScrollable: isScrollable,
          isShowIndex: isShowIndex,
          isShowTitle: isShowTitle,
          onScroll: onScroll,
        );
      case SongArrange.carousel:
        return SongCarouselWidget(
          sectionSong: sectionSong,
          isVerticalTitle: isVerticalTitle,
        );
    }
  }
}

class SongInfoWidget extends StatefulWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final bool isShowTitle;
  final SectionSong sectionSong;
  final bool isFromPlaylist;
  final VoidCallback? onScroll;
  const SongInfoWidget({
    super.key,
    this.isVerticalTitle = true,
    this.isScrollable = true,
    this.isShowIndex = true,
    this.isShowType = true,
    this.isShowTitle = true,
    this.isFromPlaylist = false,
    required this.sectionSong,
    this.onScroll,
  });

  @override
  State<SongInfoWidget> createState() => _SongInfoWidgetState();
}

class _SongInfoWidgetState extends State<SongInfoWidget> {
  late ScrollController controller;
  bool _loading = false;

  @override
  void initState() {
    controller = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (!controller.hasClients || _loading || widget.onScroll == null) return;
    if (controller.position.extentAfter < 200) {
      _loading = true;
      widget.onScroll?.call();
      Future.delayed(const Duration(seconds: 2), () => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.sectionSong.title != null && widget.isShowTitle) ...[
            RotatedTextWidget(
              text: widget.sectionSong.title!,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: SingleChildScrollView(
              physics: widget.isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: controller,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    widget.sectionSong.items!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SongCardWidget(
                        index: index + 1,
                        isShowIndex: widget.isShowIndex,
                        isShowType: widget.isShowType,
                        type: SongType.cardInfo,
                        song: widget.sectionSong.items![index],
                        onPress: () async {
                          context.read<SongBloc>().add(SongSetListSongInfoEvent(
                                widget.sectionSong.items ?? [],
                              ));
                          context
                              .read<SongBloc>()
                              .add(SongStartPlayingSectionEvent(index));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        physics: widget.isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.sectionSong.title != null && widget.isShowTitle) ...[
              Text(
                widget.sectionSong.title!,
                style: TextStyleTheme.ts20.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
            ...List.generate(
              widget.sectionSong.items!.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SongCardWidget(
                  index: index + 1,
                  isShowIndex: widget.isShowIndex,
                  isShowType: widget.isShowType,
                  type: SongType.cardInfo,
                  song: widget.sectionSong.items![index],
                  onPress: () async {
                    context.read<SongBloc>().add(SongSetListSongInfoEvent(
                          widget.sectionSong.items ?? [],
                        ));
                    context
                        .read<SongBloc>()
                        .add(SongStartPlayingSectionEvent(index));
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class SongCarouselWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final SectionSong sectionSong;
  const SongCarouselWidget({
    super.key,
    this.isVerticalTitle = true,
    required this.sectionSong,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (sectionSong.title != null) ...[
            RotatedTextWidget(
              text: sectionSong.title!,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: CarouselSlider(
              items: List.generate(
                sectionSong.items!.length,
                (index) => SongCardWidget(
                  index: index + 1,
                  isShowIndex: false,
                  isShowType: false,
                  type: SongType.cardImage,
                  size: 160,
                  song: sectionSong.items![index],
                  onPress: () async {
                    context.read<SongBloc>().add(SongSetListSongInfoEvent(
                          sectionSong.items ?? [],
                        ));
                    context
                        .read<SongBloc>()
                        .add(SongStartPlayingSectionEvent(index));
                  },
                ),
              ),
              options: CarouselOptions(
                height: 240,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.32,
                aspectRatio: 1,
                viewportFraction: 0.64,
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (sectionSong.title != null) ...[
            Text(
              sectionSong.title!,
              style: TextStyleTheme.ts20.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: CarouselSlider(
              items: List.generate(
                sectionSong.items!.length,
                (index) => SongCardWidget(
                  index: index + 1,
                  isShowIndex: false,
                  isShowType: false,
                  type: SongType.cardImage,
                  size: 160,
                  song: sectionSong.items![index],
                  onPress: () async {
                    context.read<SongBloc>().add(SongSetListSongInfoEvent(
                          sectionSong.items ?? [],
                        ));
                    context
                        .read<SongBloc>()
                        .add(SongStartPlayingSectionEvent(index));
                  },
                ),
              ),
              options: CarouselOptions(
                height: 240,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.32,
                aspectRatio: 1,
                viewportFraction: 0.64,
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              ),
            ),
          ),
        ],
      );
    }
  }
}

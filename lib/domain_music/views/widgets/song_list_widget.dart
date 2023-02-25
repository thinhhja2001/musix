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

  const SongListWidget({
    Key? key,
    this.isVerticalTitle = true,
    this.isScrollable = false,
    this.isShowIndex = false,
    this.isShowType = false,
    this.isShowTitle = true,
    required this.sectionSong,
    required this.songArrange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (songArrange) {
      case SongArrange.info:
        return SongInfoWidget(
          sectionSong: sectionSong,
          isVerticalTitle: isVerticalTitle,
          isShowType: isShowType,
          isScrollable: isScrollable,
          isShowIndex: isShowType,
          isShowTitle: isShowTitle,
        );
      case SongArrange.carousel:
        return SongCarouselWidget(
          sectionSong: sectionSong,
          isVerticalTitle: isVerticalTitle,
        );
    }
  }
}

class SongInfoWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final bool isShowTitle;
  final SectionSong sectionSong;

  const SongInfoWidget({
    super.key,
    this.isVerticalTitle = true,
    this.isScrollable = true,
    this.isShowIndex = true,
    this.isShowType = true,
    this.isShowTitle = true,
    required this.sectionSong,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (sectionSong.title != null && isShowTitle) ...[
            RotatedTextWidget(
              text: sectionSong.title!,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: SingleChildScrollView(
              physics: isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                    sectionSong.items!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SongCardWidget(
                        index: index + 1,
                        isShowIndex: isShowIndex,
                        isShowType: isShowType,
                        type: SongType.cardInfo,
                        song: sectionSong.items![index],
                        onPress: () async {
                          context.read<SongBloc>().add(SongGetInfoEvent(
                              sectionSong.items![index].encodeId!));

                          context.read<SongBloc>().add(
                                SongGetSourceEvent(
                                  sectionSong.items![index].encodeId!,
                                ),
                              );
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
        physics: isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (sectionSong.title != null && isShowTitle) ...[
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
            ...List.generate(
              sectionSong.items!.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SongCardWidget(
                  index: index + 1,
                  isShowIndex: isShowIndex,
                  isShowType: isShowType,
                  type: SongType.cardInfo,
                  song: sectionSong.items![index],
                  onPress: () async {
                    context.read<SongBloc>().add(
                        SongGetInfoEvent(sectionSong.items![index].encodeId!));

                    context.read<SongBloc>().add(
                          SongGetSourceEvent(
                            sectionSong.items![index].encodeId!,
                          ),
                        );
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
                    context.read<SongBloc>().add(
                        SongGetInfoEvent(sectionSong.items![index].encodeId!));

                    context.read<SongBloc>().add(
                          SongGetSourceEvent(
                            sectionSong.items![index].encodeId!,
                          ),
                        );
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
                    context.read<SongBloc>().add(
                        SongGetInfoEvent(sectionSong.items![index].encodeId!));

                    context.read<SongBloc>().add(
                          SongGetSourceEvent(
                            sectionSong.items![index].encodeId!,
                          ),
                        );
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:musix/domain_hub/entities/entities.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../widgets.dart';

enum PlaylistArrange {
  info,
  image,
  carousel,
  mason,
}

class PlaylistListWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final SectionPlaylist sectionPlaylist;
  final PlaylistArrange playlistArrange;

  const PlaylistListWidget({
    Key? key,
    this.isVerticalTitle = true,
    this.isScrollable = false,
    this.isShowIndex = false,
    this.isShowType = false,
    required this.sectionPlaylist,
    required this.playlistArrange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (playlistArrange) {
      case PlaylistArrange.info:
        return PlaylistInfoWidget(
          sectionPlaylist: sectionPlaylist,
          isVerticalTitle: isVerticalTitle,
          isShowType: isShowType,
          isScrollable: isScrollable,
          isShowIndex: isShowType,
        );
      case PlaylistArrange.image:
        return PlaylistImageWidget(
          sectionPlaylist: sectionPlaylist,
          isVerticalTitle: isVerticalTitle,
          isScrollable: isScrollable,
        );
      case PlaylistArrange.carousel:
        return PlaylistCarouselWidget(
          sectionPlaylist: sectionPlaylist,
          isVerticalTitle: isVerticalTitle,
        );
      case PlaylistArrange.mason:
        return PlaylistMasonWidget(
          sectionPlaylist: sectionPlaylist,
        );
    }
  }
}

class PlaylistInfoWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final SectionPlaylist sectionPlaylist;

  const PlaylistInfoWidget({
    super.key,
    this.isVerticalTitle = true,
    this.isScrollable = true,
    this.isShowIndex = true,
    this.isShowType = true,
    required this.sectionPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionPlaylist.title != null) ...[
            RotatedTextWidget(
              text: sectionPlaylist.title!,
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
                    sectionPlaylist.items!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: PlaylistCardWidget(
                        index: index + 1,
                        isShowIndex: isShowIndex,
                        isShowType: isShowType,
                        type: PlaylistType.cardInfo,
                        playlist: sectionPlaylist.items![index],
                        onPress: () {},
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (sectionPlaylist.title != null) ...[
              Text(
                sectionPlaylist.title!,
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
              sectionPlaylist.items!.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PlaylistCardWidget(
                  index: index + 1,
                  isShowIndex: isShowIndex,
                  isShowType: isShowType,
                  type: PlaylistType.cardInfo,
                  playlist: sectionPlaylist.items![index],
                  onPress: () {},
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class PlaylistImageWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final SectionPlaylist sectionPlaylist;
  const PlaylistImageWidget({
    super.key,
    this.isVerticalTitle = true,
    this.isScrollable = true,
    required this.sectionPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionPlaylist.title != null) ...[
            RotatedTextWidget(
              text: sectionPlaylist.title!,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: GridView.builder(
              physics: isScrollable
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: sectionPlaylist.items!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.84,
              ),
              itemBuilder: (context, index) => PlaylistCardWidget(
                index: index + 1,
                isShowIndex: false,
                isShowType: false,
                type: PlaylistType.cardImage,
                size: 160,
                playlist: sectionPlaylist.items![index],
                onPress: () {},
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sectionPlaylist.title != null) ...[
              Text(
                sectionPlaylist.title!,
                style: TextStyleTheme.ts20.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sectionPlaylist.items!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.84,
              ),
              itemBuilder: (context, index) => PlaylistCardWidget(
                index: index + 1,
                isShowIndex: false,
                isShowType: false,
                type: PlaylistType.cardImage,
                size: 160,
                playlist: sectionPlaylist.items![index],
                onPress: () {},
              ),
            ),
          ],
        ),
      );
    }
  }
}

class PlaylistCarouselWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final SectionPlaylist sectionPlaylist;
  const PlaylistCarouselWidget({
    super.key,
    this.isVerticalTitle = true,
    required this.sectionPlaylist,
  });
  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionPlaylist.title != null) ...[
            RotatedTextWidget(
              text: sectionPlaylist.title!,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: CarouselSlider(
              items: List.generate(
                sectionPlaylist.items!.length,
                (index) => PlaylistCardWidget(
                  index: index + 1,
                  isShowIndex: false,
                  isShowType: false,
                  type: PlaylistType.cardImage,
                  playlist: sectionPlaylist.items![index],
                  onPress: () {},
                ),
              ),
              options: CarouselOptions(
                height: 200,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionPlaylist.title != null) ...[
            Text(
              sectionPlaylist.title!,
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
                sectionPlaylist.items!.length,
                (index) => PlaylistCardWidget(
                  index: index + 1,
                  isShowIndex: false,
                  isShowType: false,
                  type: PlaylistType.cardImage,
                  size: 160,
                  playlist: sectionPlaylist.items![index],
                  onPress: () {},
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

class PlaylistMasonWidget extends StatelessWidget {
  final SectionPlaylist sectionPlaylist;

  const PlaylistMasonWidget({
    super.key,
    required this.sectionPlaylist,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      itemCount: sectionPlaylist.items!.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(
            height: 48,
            child: Text(
              sectionPlaylist.title!,
              style: TextStyleTheme.ts28.copyWith(
                fontSize: sectionPlaylist.title!.length > 10 ? 22 : 28,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          );
        }
        return PlaylistCardWidget(
          index: index + 1,
          isShowIndex: false,
          isShowType: false,
          type: PlaylistType.cardImage,
          size: 160,
          playlist: sectionPlaylist.items![index],
          onPress: () {},
        );
      },
    );
  }
}

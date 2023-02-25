import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../domain_hub/entities/entities.dart';
import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../widgets.dart';

enum ArtistArrange {
  info,
  carousel,
}

class ArtistListWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final SectionArtist sectionArtist;
  final ArtistArrange artistArrange;

  const ArtistListWidget({
    Key? key,
    this.isVerticalTitle = true,
    this.isScrollable = false,
    this.isShowIndex = false,
    this.isShowType = false,
    required this.sectionArtist,
    required this.artistArrange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (artistArrange) {
      case ArtistArrange.info:
        return ArtistInfoWidget(
          sectionArtist: sectionArtist,
          isVerticalTitle: isVerticalTitle,
          isShowType: isShowType,
          isScrollable: isScrollable,
          isShowIndex: isShowType,
        );
      case ArtistArrange.carousel:
        return ArtistCarouselWidget(
          sectionArtist: sectionArtist,
          isVerticalTitle: isVerticalTitle,
        );
    }
  }
}

class ArtistInfoWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final SectionArtist sectionArtist;

  const ArtistInfoWidget({
    super.key,
    this.isVerticalTitle = true,
    this.isScrollable = true,
    this.isShowIndex = true,
    this.isShowType = true,
    required this.sectionArtist,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionArtist.title != null) ...[
            RotatedTextWidget(
              text: sectionArtist.title!,
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
                    sectionArtist.items!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ArtistCardWidget(
                        index: index + 1,
                        isShowIndex: isShowIndex,
                        isShowType: isShowType,
                        type: ArtistType.cardInfo,
                        artist: sectionArtist.items![index],
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
            if (sectionArtist.title != null) ...[
              Text(
                sectionArtist.title!,
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
              sectionArtist.items!.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ArtistCardWidget(
                  index: index + 1,
                  isShowIndex: isShowIndex,
                  isShowType: isShowType,
                  type: ArtistType.cardInfo,
                  artist: sectionArtist.items![index],
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

class ArtistCarouselWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final SectionArtist sectionArtist;
  const ArtistCarouselWidget({
    super.key,
    this.isVerticalTitle = true,
    required this.sectionArtist,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionArtist.title != null) ...[
            RotatedTextWidget(
              text: sectionArtist.title!,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
          Expanded(
            child: CarouselSlider(
              items: List.generate(
                sectionArtist.items!.length,
                (index) => ArtistCardWidget(
                  index: index + 1,
                  isShowIndex: false,
                  isShowType: false,
                  type: ArtistType.cardImage,
                  size: 160,
                  artist: sectionArtist.items![index],
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
          if (sectionArtist.title != null) ...[
            Text(
              sectionArtist.title!,
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
                sectionArtist.items!.length,
                (index) => ArtistCardWidget(
                  index: index + 1,
                  isShowIndex: false,
                  isShowType: false,
                  type: ArtistType.cardImage,
                  size: 160,
                  artist: sectionArtist.items![index],
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

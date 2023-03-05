import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/exporter.dart';
import '../../../domain_hub/entities/entities.dart';
import '../../../global/widgets/widgets.dart';
import '../../../routing/routing_path.dart';
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
  final VoidCallback? onScroll;

  const ArtistListWidget({
    Key? key,
    this.isVerticalTitle = true,
    this.isScrollable = false,
    this.isShowIndex = false,
    this.isShowType = false,
    required this.sectionArtist,
    required this.artistArrange,
    this.onScroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sectionArtist.items?.isEmpty == true) {
      return const SizedBox.shrink();
    }
    switch (artistArrange) {
      case ArtistArrange.info:
        return ArtistInfoWidget(
          sectionArtist: sectionArtist,
          isVerticalTitle: isVerticalTitle,
          isShowType: isShowType,
          isScrollable: isScrollable,
          isShowIndex: isShowIndex,
          onScroll: onScroll,
        );
      case ArtistArrange.carousel:
        return ArtistCarouselWidget(
          sectionArtist: sectionArtist,
          isVerticalTitle: isVerticalTitle,
          isScrollable: isScrollable,
        );
    }
  }
}

class ArtistInfoWidget extends StatefulWidget {
  final bool isVerticalTitle;
  final bool isScrollable;
  final bool isShowIndex;
  final bool isShowType;
  final SectionArtist sectionArtist;
  final VoidCallback? onScroll;

  const ArtistInfoWidget({
    super.key,
    this.isVerticalTitle = true,
    this.isScrollable = true,
    this.isShowIndex = true,
    this.isShowType = true,
    required this.sectionArtist,
    this.onScroll,
  });

  @override
  State<ArtistInfoWidget> createState() => _ArtistInfoWidgetState();
}

class _ArtistInfoWidgetState extends State<ArtistInfoWidget> {
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
          if (widget.sectionArtist.title != null) ...[
            RotatedTextWidget(
              text: widget.sectionArtist.title!,
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
                    widget.sectionArtist.items!.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ArtistCardWidget(
                        index: index + 1,
                        isShowIndex: widget.isShowIndex,
                        isShowType: widget.isShowType,
                        type: ArtistType.cardInfo,
                        artist: widget.sectionArtist.items![index],
                        onPress: () {
                          context.read<ArtistBloc>().add(ArtistGetInfoEvent(
                              widget.sectionArtist.items![index].alias!));
                          Navigator.pushNamed(
                            context,
                            RoutingPath.artistInfo,
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
        physics: widget.isScrollable
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.sectionArtist.title != null) ...[
              Text(
                widget.sectionArtist.title!,
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
              widget.sectionArtist.items!.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ArtistCardWidget(
                  index: index + 1,
                  isShowIndex: widget.isShowIndex,
                  isShowType: widget.isShowType,
                  type: ArtistType.cardInfo,
                  artist: widget.sectionArtist.items![index],
                  onPress: () {
                    context.read<ArtistBloc>().add(ArtistGetInfoEvent(
                        widget.sectionArtist.items![index].alias!));
                    Navigator.pushNamed(
                      context,
                      RoutingPath.artistInfo,
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

class ArtistCarouselWidget extends StatelessWidget {
  final bool isVerticalTitle;
  final SectionArtist sectionArtist;
  final bool isScrollable;
  const ArtistCarouselWidget({
    super.key,
    this.isScrollable = false,
    this.isVerticalTitle = true,
    required this.sectionArtist,
  });

  @override
  Widget build(BuildContext context) {
    if (isVerticalTitle) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  onPress: () {
                    context.read<ArtistBloc>().add(
                        ArtistGetInfoEvent(sectionArtist.items![index].alias!));
                    Navigator.pushNamed(
                      context,
                      RoutingPath.artistInfo,
                    );
                  },
                ),
              ),
              options: CarouselOptions(
                height: 200,
                autoPlay: isScrollable,
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
                  onPress: () {
                    context.read<ArtistBloc>().add(
                        ArtistGetInfoEvent(sectionArtist.items![index].alias!));
                    Navigator.pushNamed(
                      context,
                      RoutingPath.artistInfo,
                    );
                  },
                ),
              ),
              options: CarouselOptions(
                height: 240,
                autoPlay: isScrollable,
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../entities/entities.dart';
import '../widgets.dart';

enum PlaylistArrange { list, grid, carousel }

class PlaylistListWidget extends StatelessWidget {
  final String title;
  final List<MiniPlaylist?> playlists;
  final bool isShowAll;
  final double? width;
  final double? height;
  final PlaylistArrange playlistArrange;
  final bool isScrollable;

  const PlaylistListWidget({
    Key? key,
    required this.title,
    required this.playlists,
    this.isShowAll = true,
    this.width,
    this.height,
    this.playlistArrange = PlaylistArrange.carousel,
    this.isScrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (playlistArrange) {
      case PlaylistArrange.list:
        return Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: Row(
            children: [
              RotatedTextWidget(text: title),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: isScrollable
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        playlists.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PlaylistCardWidget(
                            index: index + 1,
                            isRequestIndex: isShowAll,
                            playlist: playlists[index],
                            width: 160,
                            height: 160,
                            onPress: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case PlaylistArrange.grid:
        return Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: Row(
            children: [
              RotatedTextWidget(text: title),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: GridView.builder(
                  physics: isScrollable
                      ? const BouncingScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  itemCount: playlists.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.84,
                  ),
                  itemBuilder: (context, index) => PlaylistCardWidget(
                    playlist: playlists[index],
                  ),
                ),
              ),
            ],
          ),
        );
      case PlaylistArrange.carousel:
        return Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: Row(
            children: [
              RotatedTextWidget(text: title),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isShowAll) ...[
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'View All',
                          style: TextStyleTheme.ts18.copyWith(
                            fontWeight: FontWeight.w300,
                            color: ColorTheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                    CarouselSlider(
                      items: List.generate(
                        playlists.length,
                        (index) => PlaylistCardWidget(
                          playlist: playlists[index],
                        ),
                      ),
                      options: CarouselOptions(
                        height: 240,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.32,
                        aspectRatio: 1,
                        viewportFraction: 0.64,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }
}

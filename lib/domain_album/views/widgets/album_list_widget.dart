import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musix/global/widgets/custom_card_widget.dart';
import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/theme/theme.dart';

import '../../models/models.dart';

class AlbumListWidget extends StatelessWidget {
  final String title;
  final List<Album?> albums;
  final bool isShowAll;
  final double? width;
  final double? height;
  const AlbumListWidget({
    Key? key,
    required this.title,
    required this.albums,
    this.isShowAll = true,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  albums.length,
                  (index) => CustomCardWidget(
                    width: width ?? 240,
                    height: height ?? 240,
                    image: albums[index]!.thumbnailUrl,
                    title: albums[index]!.albumName,
                    subTitle: albums[index]!.artistName,
                    titleTextStyle: TextStyleTheme.ts15.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
            ],
          ),
        )
      ],
    );
  }
}

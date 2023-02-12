import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/theme/theme.dart';

import '../../models/models.dart';
import '../widgets.dart';

class AlbumListWidget extends StatelessWidget {
  final String title;
  final List<Album?> albums;
  final bool isShowAll;
  final double? width;
  final double? height;
  final bool isArrangeByGrid;
  const AlbumListWidget({
    Key? key,
    required this.title,
    required this.albums,
    this.isShowAll = true,
    this.width,
    this.height,
    this.isArrangeByGrid = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          if (isArrangeByGrid) ...[
            Expanded(
              child: GridView.builder(
                itemCount: albums.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.84,
                ),
                itemBuilder: (context, index) => AlbumCardWidget(
                  album: albums[index] ?? sampleAlbum,
                ),
              ),
            ),
          ] else ...[
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
                      (index) => AlbumCardWidget(
                        album: albums[index] ?? sampleAlbum,
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
        ],
      ),
    );
  }
}

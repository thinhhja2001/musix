import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/theme/theme.dart';

class YouMayLoveAlbumWidget extends StatelessWidget {
  const YouMayLoveAlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: 'You May Love'),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'View All',
                style: TextStyleTheme.ts12H20.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorTheme.primary,
                ),
              ),
            ),
            CarouselSlider(
              items: [],
              options: CarouselOptions(
                height: 168,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 3 / 4,
                viewportFraction: 1,
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              ),
            ),
          ],
        )
      ],
    );
  }
}

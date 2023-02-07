import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:musix/global/widgets/custom_card_widget.dart';

import 'package:musix/global/widgets/widgets.dart';
import 'package:musix/theme/theme.dart';
import 'package:musix/utils/fake_data/fake_data.dart';

class NewAlbumWidget extends StatelessWidget {
  const NewAlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const RotatedTextWidget(text: 'New Album'),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              CarouselSlider(
                items: List.generate(
                  albumData.length,
                  (index) => CustomCardWidget(
                      width: 240,
                      height: 240,
                      image: albumData[index]['thumbnail']!,
                      title: albumData[index]['name']!,
                      subTitle: albumData[index]['author']!),
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

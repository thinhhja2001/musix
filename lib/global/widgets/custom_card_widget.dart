import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class CustomCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String image;
  final String title;
  final String subTitle;
  final double width;
  final double height;
  const CustomCardWidget({
    Key? key,
    this.onTap,
    required this.image,
    required this.title,
    required this.subTitle,
    this.width = 168,
    this.height = 168,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              width: width,
              height: height,
              fit: BoxFit.fill,
              imageUrl: image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width * 0.8,
                height: height * 0.32,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts15.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    Text(
                      subTitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts12.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

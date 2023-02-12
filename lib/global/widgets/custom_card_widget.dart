import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class CustomCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String image;
  final String? title;
  final String? subTitle;
  final double width;
  final double height;
  final Alignment titleAlignment;
  final bool opacityTitle;
  final TextStyle titleTextStyle;

  const CustomCardWidget({
    Key? key,
    this.onTap,
    required this.image,
    this.title,
    this.subTitle,
    this.width = 168,
    this.height = 168,
    this.titleAlignment = Alignment.bottomCenter,
    this.opacityTitle = true,
    this.titleTextStyle = TextStyleTheme.ts15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
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
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            Align(
              alignment: titleAlignment,
              child: Container(
                decoration: opacityTitle
                    ? BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        overflow:
                            title!.length > 44 ? TextOverflow.ellipsis : null,
                        style: titleTextStyle.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    if (subTitle != null) ...[
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        subTitle!,
                        overflow: TextOverflow.ellipsis,
                        style: titleTextStyle.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

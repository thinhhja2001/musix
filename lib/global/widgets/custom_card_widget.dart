import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/theme.dart';
import '../../utils/utils.dart';

class CustomCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? image;
  final String? title;
  final String? subTitle;
  final double width;
  final double height;
  final Alignment titleAlignment;
  final bool opacityTitle;
  final bool isShowTitle;
  final TextStyle titleTextStyle;

  const CustomCardWidget({
    Key? key,
    this.onTap,
    this.image,
    this.title,
    this.subTitle,
    this.width = 168,
    this.height = 168,
    this.titleAlignment = Alignment.bottomCenter,
    this.opacityTitle = true,
    this.titleTextStyle = TextStyleTheme.ts15,
    this.isShowTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: image ?? AssetPath.placeImage,
              placeholder: (context, url) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Shimmer.fromColors(
                  baseColor: ColorTheme.background,
                  highlightColor: ColorTheme.backgroundDarker,
                  child: Material(
                    color: Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          if (isShowTitle)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 140,
                decoration: opacityTitle
                    ? BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                padding: const EdgeInsets.all(8),
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        overflow: title!.length > 16
                            ? TextOverflow.ellipsis
                            : TextOverflow.clip,
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
    );
  }
}

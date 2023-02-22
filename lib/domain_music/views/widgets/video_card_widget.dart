import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../../theme/theme.dart';

class VideoCardWidget extends StatelessWidget {
  const VideoCardWidget({
    Key? key,
    required this.video,
    required this.index,
    this.onPress,
    this.padding = 16,
    this.isRequestIndex = true,
    this.isHasType = false,
    this.type = 'Video',
  }) : super(key: key);

  final VideoDetail video;
  final int index;
  final VoidCallback? onPress;

  /// [isRequestIndex] for check should place index in start of card
  final bool isRequestIndex;

  /// [isHasType] for check type of card
  final bool isHasType;

  /// [type] for check type of card
  final String type;

  /// [padding] for top and right
  final double padding;

  @override
  Widget build(BuildContext context) {
    /// Support for showing for dynamic type
    if (isHasType) {
      return Padding(
        padding: EdgeInsets.only(top: padding, right: padding),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: ColorTheme.primaryLighten.withOpacity(0.3),
          onTap: onPress,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isRequestIndex) ...[
                  Center(
                    child: Text(
                      '#$index',
                      style: TextStyleTheme.ts16.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 26 - (index.toString().length - 1) * 10,
                  ),
                ],
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      3,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        video.thumbnailM,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts14.copyWith(
                          color: ColorTheme.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        video.artistsNames,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts12.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorTheme.primary,
                        ),
                      ),
                      Text(
                        type,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts10.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.8,
                        color: ColorTheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 24,
                    height: 24,
                    child: const Center(
                      child: Icon(
                        Icons.more_horiz,
                        color: ColorTheme.primary,
                        size: 16,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    /// Default Widget
    return Padding(
      padding: EdgeInsets.only(top: padding, right: padding),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: ColorTheme.primaryLighten.withOpacity(0.3),
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isRequestIndex) ...[
                Center(
                  child: Text(
                    '#$index',
                    style: TextStyleTheme.ts16.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 26 - (index.toString().length - 1) * 10,
                ),
              ],
              Container(
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    3,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      video.thumbnailM,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(180),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.8,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts14.copyWith(
                        color: ColorTheme.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      video.artistsNames,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts12.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.8,
                      color: ColorTheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: 24,
                  height: 24,
                  child: const Center(
                    child: Icon(
                      Icons.more_horiz,
                      color: ColorTheme.primary,
                      size: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

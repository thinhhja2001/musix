import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/models.dart';

import '../../../global/widgets/custom_card_widget.dart';
import '../../../theme/theme.dart';

class AlbumCardWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final int? index;
  final VoidCallback? onPress;
  final Album album;

  /// [isRequestIndex] for check should place index in start of card
  final bool isRequestIndex;

  /// [isHasType] for check type of card
  final bool isHasType;

  /// [type] for check type of card
  final String type;

  /// [padding] for top and right
  final double padding;

  const AlbumCardWidget({
    Key? key,
    this.width,
    this.height,
    this.index,
    this.onPress,
    required this.album,
    this.isHasType = false,
    this.isRequestIndex = false,
    this.padding = 16,
    this.type = 'Album',
  }) : super(key: key);

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
                        album.thumbnailUrl,
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
                        album.albumName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts14.copyWith(
                          color: ColorTheme.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        album.artistName,
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

    return CustomCardWidget(
      width: width ?? 240,
      height: height ?? 240,
      image: album.thumbnailUrl,
      title: album.albumName,
      subTitle: album.artistName,
      onTap: onPress,
      titleTextStyle: TextStyleTheme.ts15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

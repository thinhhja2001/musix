import 'package:flutter/material.dart';
import 'package:musix/domain_artist/entities/artist/mini_artist.dart';

import '../../../theme/theme.dart';

class ArtistCardWidget extends StatelessWidget {
  const ArtistCardWidget({
    Key? key,
    required this.artist,
    required this.index,
    this.onPress,
    this.padding = 16,
    this.isRequestIndex = true,
    this.isHasType = false,
    this.type = 'Artist',
  }) : super(key: key);

  final MiniArtist artist;
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
                      artist.thumbnailM!,
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      artist.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts14.copyWith(
                        color: ColorTheme.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (isHasType) ...[
                      Text(
                        type,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts10.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]
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

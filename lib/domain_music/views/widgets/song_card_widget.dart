import 'package:flutter/material.dart';
import 'package:musix/domain_music/views/widgets/view_song_detail_widget.dart';
import 'package:musix/theme/theme.dart';

import '../../entities/song.dart';

class SongCardWidget extends StatelessWidget {
  const SongCardWidget({
    Key? key,
    required this.song,
    required this.index,
    this.onPress,
    this.padding = 16,
    this.isRequestIndex = true,
    this.isHasType = false,
    this.type = 'Song',
  }) : super(key: key);

  final Song song;
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
                  image: song.thumbnail == null
                      ? null
                      : DecorationImage(
                          image: NetworkImage(
                            song.thumbnail!,
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
                      song.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts14.copyWith(
                        color: ColorTheme.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      song.artistsNames!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleTheme.ts12.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorTheme.primary,
                      ),
                    ),
                    if (isHasType) ...[
                      Text(
                        type,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleTheme.ts10.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                        ),
                      ),
                    ],
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
                  child: Center(
                    child: InkWell(
                      onTap: () => {
                        showModalBottomSheet(
                          context: context, backgroundColor: Colors.transparent,
                          // isScrollControlled: true,
                          builder: (context) => ViewSongDetailWidget(
                            song: song,
                          ),
                        )
                      },
                      child: const Icon(
                        Icons.more_horiz,
                        color: ColorTheme.primary,
                        size: 16,
                      ),
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

import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../entities/entities.dart';
import '../widgets.dart';

enum SongType {
  cardImage,
  cardInfo,
}

class SongCardWidget extends StatelessWidget {
  final SongInfo song;
  final VoidCallback? onPress;
  final int index;
  final bool isShowIndex;
  final bool isShowType;
  final double? size;
  final SongType type;

  const SongCardWidget({
    super.key,
    required this.song,
    this.onPress,
    this.index = 0,
    this.isShowIndex = false,
    this.isShowType = false,
    this.size,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SongType.cardImage:
        return SongCardImageWidget(
          song: song,
          onPress: onPress,
          size: size,
        );
      case SongType.cardInfo:
        return SongCardInfoWidget(
          song: song,
          index: index,
          isShowIndex: isShowIndex,
          isShowType: isShowType,
          onPress: onPress,
        );
    }
  }
}

class SongCardInfoWidget extends StatelessWidget {
  final SongInfo song;
  final VoidCallback? onPress;
  final int index;
  final bool isShowIndex;
  final bool isShowType;

  const SongCardInfoWidget({
    super.key,
    required this.song,
    this.onPress,
    this.index = 0,
    this.isShowIndex = false,
    this.isShowType = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardInfoWidget(
      index: index,
      encodeId: song.encodeId!,
      image: song.thumbnailM!,
      title: song.title!,
      subTitle: song.artistsNames!,
      type: isShowType ? 'Song' : null,
      isShowIndex: isShowIndex,
      padding: 0,
      onCardPress: onPress,
      onButtonPress: () => {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => ViewSongDetailWidget(
            song: song,
          ),
        )
      },
    );
  }
}

class SongCardImageWidget extends StatelessWidget {
  final double? size;
  final SongInfo song;
  final VoidCallback? onPress;

  const SongCardImageWidget({
    super.key,
    this.size,
    required this.song,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      width: size ?? 240,
      height: size ?? 240,
      image: song.thumbnailM!,
      title: song.title!,
      subTitle: song.artistsNames!,
      onTap: onPress,
      titleTextStyle: TextStyleTheme.ts15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

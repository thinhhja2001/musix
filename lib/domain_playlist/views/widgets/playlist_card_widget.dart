import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../entities/entities.dart';

enum PlaylistType {
  cardImage,
  cardInfo,
}

class PlaylistCardWidget extends StatelessWidget {
  final MiniPlaylist playlist;
  final VoidCallback? onPress;
  final int index;
  final bool isShowIndex;
  final bool isShowType;
  final double? size;
  final PlaylistType type;

  const PlaylistCardWidget({
    super.key,
    required this.playlist,
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
      case PlaylistType.cardImage:
        return PlaylistCardImageWidget(
          playlist: playlist,
          onPress: onPress,
          size: size,
        );
      case PlaylistType.cardInfo:
        return PlaylistCardInfoWidget(
          playlist: playlist,
          index: index,
          isShowIndex: isShowIndex,
          isShowType: isShowType,
          onPress: onPress,
        );
    }
  }
}

class PlaylistCardInfoWidget extends StatelessWidget {
  final MiniPlaylist playlist;
  final VoidCallback? onPress;
  final int index;
  final bool isShowIndex;
  final bool isShowType;

  const PlaylistCardInfoWidget({
    super.key,
    required this.playlist,
    this.onPress,
    this.index = 0,
    this.isShowIndex = false,
    this.isShowType = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardInfoWidget(
      index: index,
      image: playlist.thumbnailM,
      title: playlist.title!,
      subTitle: playlist.artistsNames,
      type: isShowType ? 'Playlist' : null,
      isShowIndex: isShowIndex,
      padding: 0,
      onCardPress: onPress,

      /// TODO: code for button press
      onButtonPress: () {},
    );
  }
}

class PlaylistCardImageWidget extends StatelessWidget {
  final double? size;
  final MiniPlaylist playlist;
  final VoidCallback? onPress;

  const PlaylistCardImageWidget({
    super.key,
    this.size,
    required this.playlist,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      width: size ?? 240,
      height: size ?? 240,
      image: playlist.thumbnailM,
      title: playlist.title!,
      subTitle: playlist.artistsNames,
      onTap: onPress,
      titleTextStyle: TextStyleTheme.ts15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

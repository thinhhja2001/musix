import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../entities/artist/mini_artist.dart';
import '../widgets.dart';

enum ArtistType {
  cardImage,
  cardInfo,
}

class ArtistCardWidget extends StatelessWidget {
  final MiniArtist artist;
  final VoidCallback? onPress;
  final int index;
  final bool isShowIndex;
  final bool isShowType;
  final double? size;
  final ArtistType type;

  const ArtistCardWidget({
    super.key,
    required this.artist,
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
      case ArtistType.cardImage:
        return ArtistCardImageWidget(
          artist: artist,
          onPress: onPress,
          size: size,
        );
      case ArtistType.cardInfo:
        return ArtistCardInfoWidget(
          artist: artist,
          index: index,
          isShowIndex: isShowIndex,
          isShowType: isShowType,
          onPress: onPress,
        );
    }
  }
}

class ArtistCardInfoWidget extends StatelessWidget {
  final MiniArtist artist;
  final VoidCallback? onPress;
  final int index;
  final bool isShowIndex;
  final bool isShowType;

  const ArtistCardInfoWidget({
    super.key,
    required this.artist,
    this.onPress,
    this.index = 0,
    this.isShowIndex = false,
    this.isShowType = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardInfoWidget(
      index: index,
      image: artist.thumbnailM,
      title: artist.name!,
      type: isShowType ? 'Artist' : null,
      isShowIndex: isShowIndex,
      padding: 0,
      onCardPress: onPress,
      onButtonPress: () => {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) => ViewArtistDetailWidget(
            artist: artist,
          ),
        )
      },
      subTitle: '',
    );
  }
}

class ArtistCardImageWidget extends StatelessWidget {
  final double? size;
  final MiniArtist artist;
  final VoidCallback? onPress;

  const ArtistCardImageWidget({
    super.key,
    this.size,
    required this.artist,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      width: size ?? 240,
      height: size ?? 240,
      image: artist.thumbnailM,
      title: artist.name!,
      onTap: onPress,
      isShowTitle: true,
      titleTextStyle: TextStyleTheme.ts15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:musix/domain_album/models/models.dart';

import '../../../global/widgets/custom_card_widget.dart';
import '../../../theme/theme.dart';

class AlbumCardWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final int? index;
  final VoidCallback? onTap;
  final Album album;
  const AlbumCardWidget({
    Key? key,
    this.width,
    this.height,
    this.index,
    this.onTap,
    required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      width: width ?? 240,
      height: height ?? 240,
      image: album.thumbnailUrl,
      title: album.albumName,
      subTitle: album.artistName,
      titleTextStyle: TextStyleTheme.ts15.copyWith(
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../global/widgets/custom_card_widget.dart';
import '../../models/models.dart';

class AlbumSelectionWidget extends StatelessWidget {
  const AlbumSelectionWidget({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      width: 240,
      height: 240,
      image: album.thumbnailUrl,
      title: album.albumName,
      subTitle: album.artistName,
    );
  }
}

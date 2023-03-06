import 'package:flutter/material.dart';

import '../../../global/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';

class ViewArtistDetailWidget extends StatelessWidget {
  const ViewArtistDetailWidget({
    super.key,
    required this.artist,
  });
  final MiniArtist artist;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorTheme.backgroundDarker,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              artist.thumbnailM ?? AssetPath.placeImage,
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            artist.name ?? "",
            style: TextStyleTheme.ts20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DetailChildWidget(
            icon: Icons.favorite_outline,
            data: "Like",
            onPress: () {},
          ),
          const SizedBox(
            height: 12,
          ),
          DetailChildWidget(
            icon: Icons.do_not_disturb_alt_outlined,
            data: "Block",
            onPress: () {},
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

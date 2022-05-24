import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/album.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class AlbumSummaryCard extends StatelessWidget {
  const AlbumSummaryCard({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(album.thumbnailUrl)),
              color: kPrimaryColorLighten),
        ),
        horizontalSpaceSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                album.title,
                overflow: TextOverflow.ellipsis,
                style: kDefaultHintStyle.copyWith(color: Colors.white),
              ),
              Text(
                '${album.songs.length} songs',
                style: kDefaultHintStyle.copyWith(color: kPrimaryColor),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/images/three_dot.svg'),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class AlbumSummaryCard extends StatelessWidget {
  const AlbumSummaryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kPrimaryColorLighten),
          child: const Icon(
            Icons.favorite_border,
            color: Colors.white,
          ),
        ),
        horizontalSpaceSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Love album',
                overflow: TextOverflow.ellipsis,
                style: kDefaultHintStyle.copyWith(color: Colors.white),
              ),
              Text(
                '12 songs',
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

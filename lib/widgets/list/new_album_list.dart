import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import '../playlist_card.dart';

class NewAlbumList extends StatelessWidget {
  const NewAlbumList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          const RotatedBox(
            quarterTurns: 3,
            child: Text(
              "New Albums",
              style: kDefaultTitleStyle,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      19,
                      (index) => const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: PlaylistCard(),
                          ))),
            ),
          )
        ],
      ),
    );
  }
}

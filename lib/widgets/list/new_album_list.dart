import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

import '../../utils/constant.dart';
import '../music/album_card.dart';

class NewAlbumList extends StatelessWidget {
  const NewAlbumList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: kDefaultTitleStyle.copyWith(
                  color: kPrimaryColor,
                ),
              )),
          Row(
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
                          (index) => AlbumCard(
                                album: fakeAlbumData,
                              ))),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

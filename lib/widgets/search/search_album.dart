import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';

import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../music/album/album_card.dart';

class SearchAlbum extends StatelessWidget {
  const SearchAlbum({Key? key, required this.albumList}) : super(key: key);
  final List<Map<String, dynamic>> albumList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:15.0, right: 15.0),
      child: Row(
        children: [
          const RotatedBox(
            quarterTurns: -1,
            child: Text(
              "Albums",
              style: kDefaultTitleStyle,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    albumList.length,
                    (index) => AlbumCard(
                          album: new Album(
                              id: albumList[index]['id'],
                              songs: albumList[index]['songs'],
                              title: albumList[index]['title'],
                              artistNames: albumList[index]['artistNames'],
                              artistLink: albumList[index]['artistLink'],
                              thumbnailUrl: albumList[index]['thumbnailUrl']),
                        ))),
          )),
        ],
      ),
    );
  }
}

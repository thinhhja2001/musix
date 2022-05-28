import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/enums.dart';

import '../../../models/album.dart';
import '../../../models/song.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class AlbumSummaryCard extends StatelessWidget {
  const AlbumSummaryCard({
    Key? key,
    required this.album,
    this.selectedSong,
    required this.albumSummaryFunction,
  }) : super(key: key);
  final Album album;
  final AlbumSummaryFunction albumSummaryFunction;

  ///Only pass selectedSong when [albumSummaryFunction] is [AlbumSummaryFunction.add]
  final Song? selectedSong;
  @override
  Widget build(BuildContext context) {
    void _addSongToPlaylist() async {
      if (albumSummaryFunction == AlbumSummaryFunction.add &&
          selectedSong == null) {
        throw Exception(
            'Error albumSummaryFunction == AlbumSummaryFunction.add && selectedSong != null is not true');
      }
      PlaylistMethods.addSongToExistedPlaylist(selectedSong!, album);
      Navigator.pop(context);
    }

    void _getToAlbumPage() {
      //Get to album page
    }
    return InkWell(
      onTap: () async {
        albumSummaryFunction == AlbumSummaryFunction.add
            ? _addSongToPlaylist()
            : _getToAlbumPage();
      },
      child: Row(
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
      ),
    );
  }
}

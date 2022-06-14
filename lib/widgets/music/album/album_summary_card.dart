import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/enums.dart';
import 'package:musix/widgets/music/album/edit_playlist_widget.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              showEditPlaylistBottomSheet(album: album, context: context);
            },
            backgroundColor: kPrimaryColor,
            foregroundColor: Colors.white,
            label: "Edit",
            borderRadius: BorderRadius.circular(5),
            icon: MdiIcons.pencil,
          ),
          horizontalSpaceSmall,
          SlidableAction(
            onPressed: (context) {
              openAskBeforeDeletingContext(album: album, context: context);
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            label: "Delete",
            borderRadius: BorderRadius.circular(5),
            icon: MdiIcons.delete,
          ),
        ]),
        child: InkWell(
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
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(album.thumbnailUrl)),
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
            ],
          ),
        ),
      ),
    );
  }
}

void openAskBeforeDeletingContext(
    {required Album album, required BuildContext context}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kBackgroundColor,
          title: Text(
            'Are you sure want to delete "${album.title}"',
            style: kDefaultTextStyle,
          ),
          content: Text(
            'This will permanently delete this album',
            style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await PlaylistMethods.deleteCustomPlaylist(album);
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

void showEditPlaylistBottomSheet(
    {required Album album, required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return EditPlaylistWidget(
          album: album,
        );
      });
}

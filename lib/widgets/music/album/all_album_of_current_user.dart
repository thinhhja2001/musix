import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/song.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/utils/enums.dart';
import 'package:musix/widgets/customs/custom_button.dart';
import 'package:musix/widgets/music/album/album_summary_card.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'add_playlist_widget.dart';

class AllAlbumOfCurrentUser extends StatelessWidget {
  const AllAlbumOfCurrentUser({
    Key? key,
    required this.song,
  }) : super(key: key);
  final Song song;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
        future: PlaylistMethods.getAllAlbumOfCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.95,
              decoration: const BoxDecoration(
                color: kBackgroundColor,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Playlists",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      verticalSpaceSmall,
                      snapshot.data!.isNotEmpty
                          ? _AllAlbum(snapshot: snapshot)
                          : const Text(
                              "You don't have any playlist. Create one now",
                              style: kDefaultTextStyle,
                            ),
                      verticalSpaceSmall,
                      CustomButton(
                          onPress: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => AddPlaylistWidget(
                                      song: song,
                                    ));
                          },
                          content: "Add new Playlist",
                          isLoading: false)
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
            color: kBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ),
          );
        });
  }
}

class _AllAlbum extends StatelessWidget {
  const _AllAlbum({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot<List<Album>> snapshot;
  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Column(
      children: List.generate(
          snapshot.data!.length,
          (index) => AlbumSummaryCard(
                albumSummaryFunction: AlbumSummaryFunction.add,
                selectedSong: audioPlayerProvider.currentSong,
                album: snapshot.data![index],
              )),
    );
  }
}

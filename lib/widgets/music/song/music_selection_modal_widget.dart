import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/screens/artist_screen.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/album/all_album_of_current_user.dart';
import 'package:musix/widgets/music/button/favorite_icon_button.dart';
import 'package:provider/provider.dart';

import '../../../models/song.dart';
import '../../../providers/artist_provider.dart';
import '../../../providers/audio_player_provider.dart';
import '../../../resources/general_music_methods.dart';
import '../../../resources/song_methods.dart';
import 'modal_item.dart';

class MusicSelectionModal extends StatefulWidget {
  const MusicSelectionModal({Key? key, required this.song}) : super(key: key);

  final Song song;

  @override
  State<MusicSelectionModal> createState() => _MusicSelectionModalState();
}

class _MusicSelectionModalState extends State<MusicSelectionModal> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final AudioPlayerProvider audioPlayerProvider =
    Provider.of<AudioPlayerProvider>(context);
    ArtistProvider artistProvider = Provider.of<ArtistProvider>(context);

    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      height: screenSize.height * 0.9,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.network(widget.song.thumbnailUrl),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              widget.song.name,
              style: kDefaultTitleStyle,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.song.artistName,
            style: kDefaultHintStyle,
          ),
          Row(
            
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: GeneralMusicMethods.getAllFavoriteObject(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final songs = snapshot.data!.get('songs');
                      return InkWell(
                        onTap: () {
                          SongMethods.onFavoriteSongClickHandler(
                          widget.song);
                        },
                        child: ModalItem(
                            icon: songs.contains(widget.song.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            title: songs.contains(widget.song.id) ? "Favorited" : "Add to Favorite"),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: ((context) {
                    return AllAlbumOfCurrentUser(song: widget.song);
                  }));
            },
            child: ModalItem(icon: Icons.album, title: "Add to playlist"),
          ),
          InkWell(
            onTap: () {
              artistProvider.getData(widget.song.artistName);
              Get.to(ArtistScreen());
            },
            child: ModalItem(icon: Icons.person, title: "View artist"),
          ),
        ],
      ),
    );
  }
}

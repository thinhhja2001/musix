import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/song.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';

class MusicSelectionWidget extends StatelessWidget {
  const MusicSelectionWidget({
    Key? key,
    required this.index,
    required this.song,
    this.album,
  }) : super(key: key);
  final int index;
  final Song song;
  final Album? album;
  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: song.audioUrl.isNotEmpty
          ? _PlayableSongWidget(
              audioPlayerProvider: audioPlayerProvider,
              song: song,
              album: album,
              index: index)
          : _UnplayableSongWidget(
              audioPlayerProvider: audioPlayerProvider,
              song: song,
              index: index),
    );
  }
}

class _PlayableSongWidget extends StatelessWidget {
  const _PlayableSongWidget({
    Key? key,
    required this.audioPlayerProvider,
    required this.song,
    required this.index,
    this.album,
  }) : super(key: key);
  final Album? album;

  final AudioPlayerProvider audioPlayerProvider;
  final Song song;
  final int index;

  @override
  Widget build(BuildContext context) {
    String _getIndexInString(int index) {
      return index <= 8 ? "#0${index + 1}" : "#${index + 1}";
    }

    _playAlbum() {
      audioPlayerProvider.playAlbum(album: album!, index: index);
    }

    _playSong() {
      audioPlayerProvider.playSong(song);
      audioPlayerProvider.removeCurrentAlbum();
    }

    return InkWell(
      onTap: () => album != null ? _playAlbum() : _playSong(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _getIndexInString(index),
              style: kDefaultTitleStyle.copyWith(fontSize: 16),
            ),
          ),
          horizontalSpaceSmall,
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                    image: NetworkImage(song.thumbnailUrl), fit: BoxFit.cover)),
          ),
          horizontalSpaceSmall,
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    song.name,
                    overflow: TextOverflow.ellipsis,
                    style: kDefaultTitleStyle.copyWith(
                        fontSize: 16,
                        color: song.id == audioPlayerProvider.currentSong.id
                            ? kPrimaryColor
                            : Colors.white),
                  ),
                  Text(
                    song.artistName,
                    style: kDefaultTitleStyle.copyWith(
                        fontSize: 14, color: Colors.grey),
                  )
                ],
              )),
          Expanded(
              child: IconButton(
            onPressed: () => {},
            icon: const Icon(
              MdiIcons.dotsHorizontal,
              color: kPrimaryColor,
            ),
          ))
        ],
      ),
    );
  }
}

class _UnplayableSongWidget extends StatelessWidget {
  const _UnplayableSongWidget({
    Key? key,
    required this.audioPlayerProvider,
    required this.song,
    required this.index,
  }) : super(key: key);

  final AudioPlayerProvider audioPlayerProvider;
  final Song song;
  final int index;

  @override
  Widget build(BuildContext context) {
    String _getIndexInString(int index) {
      return index <= 8 ? "#0${index + 1}" : "#${index + 1}";
    }

    return InkWell(
      onTap: () => showSnackBar(
          'This song is not available right now', context, Colors.red),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffdddddd).withOpacity(0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                _getIndexInString(index),
                style: kDefaultTitleStyle.copyWith(fontSize: 16),
              ),
            ),
            horizontalSpaceSmall,
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                      image: NetworkImage(song.thumbnailUrl),
                      fit: BoxFit.cover)),
            ),
            horizontalSpaceSmall,
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      overflow: TextOverflow.ellipsis,
                      style: kDefaultTitleStyle.copyWith(
                          fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      song.artistName,
                      style: kDefaultTitleStyle.copyWith(
                          fontSize: 14, color: Colors.grey),
                    )
                  ],
                )),
            Expanded(
                child: IconButton(
              onPressed: () => {},
              icon: const Icon(
                MdiIcons.dotsHorizontal,
                color: kPrimaryColor,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

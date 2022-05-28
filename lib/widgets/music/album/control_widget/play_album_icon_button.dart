import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:provider/provider.dart';

class PlayAlbumIconButton extends StatelessWidget {
  const PlayAlbumIconButton({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context);
    return Container(
      height: 35,
      width: 35,
      decoration:
          const BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
      child: IconButton(
        onPressed: () =>
            audioPlayerProvider.playAlbum(album: album, context: context),
        icon: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
      ),
    );
  }
}

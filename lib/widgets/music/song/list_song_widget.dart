import 'package:flutter/material.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/music/song/music_selection_widget.dart';

class ListSongWidget extends StatelessWidget {
  const ListSongWidget({
    Key? key,
    required this.songsKey,
  }) : super(key: key);
  final List songsKey;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SongMethods.getListSongDataByKeys(songsKey),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return const Center(
              child: Text(
                "Listen history is empty.",
                style: kDefaultTextStyle,
              ),
            );
          } else {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, position) => MusicSelectionWidget(
                          index: position,
                          song: snapshot.data[position],
                        )),
              ],
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          );
        }
      },
    );
  }
}

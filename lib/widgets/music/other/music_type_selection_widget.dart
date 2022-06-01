import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/models/song_types.dart';
import 'package:musix/screens/album_screen_by_song_type.dart';
import 'package:musix/utils/constant.dart';

class MusicTypeSelectionWidget extends StatelessWidget {
  const MusicTypeSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const RotatedBox(
            quarterTurns: 3,
            child: Text(
              'Topics',
              style: kDefaultTitleStyle,
            )),
        horizontalSpaceSmall,
        Expanded(
          child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.2,
              child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  children: List.generate(
                      songTypes.length,
                      (index) => _MusicTypeSelectionCard(
                            songType: songTypes[index],
                          )))),
        ),
      ]),
    );
  }
}

class _MusicTypeSelectionCard extends StatelessWidget {
  const _MusicTypeSelectionCard({
    Key? key,
    required this.songType,
  }) : super(key: key);
  final SongType songType;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        AlbumScreenBySongType(songType: songType),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(songType.imageUrl))),
        child: Center(
            child: Text(
          songType.type,
          style: kDefaultHintStyle.copyWith(color: Colors.white, fontSize: 14),
        )),
      ),
    );
  }
}

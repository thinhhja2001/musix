import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/song_types.dart';
import 'package:musix/providers/custom_bottom_bar_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_json.dart';
import 'package:provider/provider.dart';

class AlbumScreenBySongType extends StatelessWidget {
  const AlbumScreenBySongType({Key? key, required this.songType})
      : super(key: key);
  final SongType songType;
  @override
  Widget build(BuildContext context) {
    CustomBottomBarProvider customBottomBarProvider =
        Provider.of<CustomBottomBarProvider>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: customBottomBarProvider.customBottomBar,
      body: Stack(children: [
        buildBlurredImage(),
        SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                goBackButton(),
                verticalSpaceSmall,
                Text(
                  songType.type,
                  style: kDefaultTextStyle,
                ),
                verticalSpaceSmall,
                _ListAlbumByTypeWidget(songType: songType)
              ],
            ),
          ),
        ))
      ]),
    );
  }
}

class _ListAlbumByTypeWidget extends StatelessWidget {
  const _ListAlbumByTypeWidget({
    Key? key,
    required this.songType,
  }) : super(key: key);

  final SongType songType;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: ZingMP3API.getAllAlbumKeyByName(songType.type, 50),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 10,
              childAspectRatio: 0.95,
              crossAxisCount: 2,
              children: List.generate(
                  snapshot.data!.length,
                  (index) => AlbumCardFromJSon(
                      albumData: snapshot.data!.elementAt(index))),
            );
          }

          return Container();
        });
  }
}

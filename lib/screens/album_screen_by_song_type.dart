import 'package:flutter/material.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/song_types.dart';
import 'package:musix/providers/custom_bottom_bar_provider.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/music/album/album_card/album_card_from_json.dart';
import 'package:provider/provider.dart';

class AllAlbumByNameScreen extends StatelessWidget {
  const AllAlbumByNameScreen({
    Key? key,
    required this.name,
    required this.quantity,
  }) : super(key: key);
  final String name;
  final int quantity;
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
                  name,
                  style: kDefaultTextStyle,
                ),
                verticalSpaceSmall,
                _ListAlbumWidget(
                  name: name,
                  quantity: quantity,
                )
              ],
            ),
          ),
        ))
      ]),
    );
  }
}

class _ListAlbumWidget extends StatelessWidget {
  const _ListAlbumWidget({
    Key? key,
    required this.name,
    required this.quantity,
  }) : super(key: key);

  final String name;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: ZingMP3API.getAllAlbumKeyByName(
            name == 'Immortalize' ? "Bất hủ" : name, quantity),
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

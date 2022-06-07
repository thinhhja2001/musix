import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/providers/artist_provider.dart';
import 'package:musix/providers/audio_player_provider.dart';
import 'package:musix/screens/artist_screen.dart';
import 'package:musix/widgets/music/song/music_selection_widget.dart';
import 'package:provider/provider.dart';

import '../../providers/search_provider.dart';
import 'artist_component.dart';

class SearchCateGory extends StatelessWidget {
  const SearchCateGory(
      {Key? key, required this.componentList, required this.searchType})
      : super(key: key);
  final List<Map<String, dynamic>> componentList;
  final int searchType;

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider = Provider.of<SearchProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: RotatedBox(
                quarterTurns: -1,
                child: Text(
                  searchProvider.SearchCategoryType(searchType),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 9,
              child: componentList.length == 0
                  ? Container(
                      height: 60,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No data",
                              style: TextStyle(color: Colors.white),
                            ),
                          ]),
                    )
                  : MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: componentList.length,
                        itemBuilder: (context, index) {
                          return new InkWell(
                              onTap: () {
                                switch (searchType) {
                                  case 1:
                                    context
                                        .read<AudioPlayerProvider>()
                                        .playSong(
                                          searchProvider.songs[index],
                                        );
                                    break;
                                  default:
                                    context
                                        .read<ArtistProvider>()
                                        .getData(componentList[index]['name']);
                                    Get.to(ArtistScreen(
                                        artist: componentList[index]));
                                    break;
                                }
                              },
                              child: searchType == 1
                                  ? MusicSelectionWidget(
                                      index: index,
                                      song: searchProvider.songs[index])
                                  //  SearchComponent(
                                  //     artist: componentList[index]
                                  //         ['artistName'],
                                  //     title: componentList[index]['name'],
                                  //     imgLink: componentList[index]
                                  //         ['thumbnailUrl'],
                                  //   )
                                  : ArtistComponent(
                                      artist: componentList[index]['name'],
                                      imgLink: componentList[index]
                                          ['thumbnailUrl'],
                                    ));
                        },
                      ),
                    ))
        ],
      ),
    );
  }
}

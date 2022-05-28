import 'package:flutter/material.dart';
import 'package:musix/providers/search_provider.dart';
import 'package:musix/widgets/search/search_album.dart';
import 'package:musix/widgets/search/search_bar.dart';
import 'package:musix/widgets/search/search_category.dart';
import 'package:musix/widgets/search/search_classify.dart';
import 'package:musix/widgets/search/search_component.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SearchBar(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => searchProvider.IndexClick(0),
                  child: SearchClassify(
                      icon: Icons.star_border,
                      text: "All",
                      isClicked: searchProvider.indexClicked[0]),
                ),
                GestureDetector(
                  onTap: () => searchProvider.IndexClick(1),
                  child: SearchClassify(
                      icon: Icons.music_note,
                      text: "Songs",
                      isClicked: searchProvider.indexClicked[1]),
                ),
                GestureDetector(
                  onTap: () => searchProvider.IndexClick(2),
                  child: SearchClassify(
                      icon: Icons.person,
                      text: "Artist",
                      isClicked: searchProvider.indexClicked[2]),
                ),
                GestureDetector(
                  onTap: () => searchProvider.IndexClick(3),
                  child: SearchClassify(
                      icon: Icons.album,
                      text: "Album",
                      isClicked: searchProvider.indexClicked[3]),
                ),
              ],
            ),
          ),
          if (searchProvider.Loading) ...[
            CircularProgressIndicator(),
          ] else ...{
            if (searchProvider.classify_index == 0) ...[
              SearchCateGory(
                componentList: searchProvider.songList,
                searchType: 1,
              ),
              SizedBox(
                height: 30,
              ),
              SearchCateGory(
                componentList: searchProvider.artistList,
                searchType: 2,
              ),
              SizedBox(
                height: 30,
              ),
              SearchAlbum(albumList: searchProvider.albumList),
            ] else if (searchProvider.classify_index == 1) ...[
              SearchCateGory(
                componentList: searchProvider.songList,
                searchType: 1,
              ),
            ] else if (searchProvider.classify_index == 2) ...[
              SearchCateGory(
                componentList: searchProvider.artistList,
                searchType: 2,
              ),
            ] else ...{
              SearchAlbum(albumList: searchProvider.albumList),
            }
          }
        ],
      ),
    );
  }
}

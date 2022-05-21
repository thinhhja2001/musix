import 'package:flutter/material.dart';
import 'package:musix/widgets/search/search_bar.dart';
import 'package:musix/widgets/search/search_component.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          SearchBar(),
          SearchComponent(
              title: "We Don't Talk Anymore",
              artist: "Charlie Puth",
              imgLink:
                  "https://avatar-ex-swe.nixcdn.com/song/2017/09/27/a/9/e/f/1506480482657_640.jpg"),
                  SizedBox(height: 30,),
                  SearchComponent(
              title: "We Don't Talk Anymore",
              artist: "Charlie Puth",
              imgLink:
                  "https://avatar-ex-swe.nixcdn.com/song/2017/09/27/a/9/e/f/1506480482657_640.jpg"),
                  SizedBox(height: 30),
                  SearchComponent(
              title: "We Don't Talk Anymore",
              artist: "Charlie Puth",
              imgLink:
                  "https://avatar-ex-swe.nixcdn.com/song/2017/09/27/a/9/e/f/1506480482657_640.jpg"),
        ],
      ),
    );
  }
}

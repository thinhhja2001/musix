import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/list/recent_music_list.dart';
import 'package:musix/widgets/playlist_card.dart';

import '../widgets/customs/custom_bottom_navigation_bar.dart';
import '../widgets/home/profile_card.dart';
import '../widgets/list/new_album_list.dart';
import '../widgets/music_selection_widget.dart';
import '../widgets/video_player/weekly_music_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<CustomBottomBarItem> bottomBarItems = [
      CustomBottomBarItem(
          icon: const Icon(Icons.star_outline),
          title: const Text("Billboard"),
          unselectedColor: Colors.white,
          selectedColor: Colors.black),
      CustomBottomBarItem(
          icon: const Icon(Icons.favorite_outline),
          title: const Text("Explore"),
          unselectedColor: Colors.white,
          selectedColor: Colors.black),
      CustomBottomBarItem(
          icon: const Icon(Icons.search_outlined),
          title: const Text("Search"),
          unselectedColor: Colors.white,
          selectedColor: Colors.black),
    ];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: CustomBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: bottomBarItems),
      body: Stack(
        children: [
          buildBlurredImage(),
          verticalSpaceLarge,
          SafeArea(
              child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            child: const CustomScrollView(
              slivers: [
                ProfileCard(name: "John Doe"),
                verticalSliverPaddingMedium,
                NewAlbumList(),
                verticalSliverPaddingMedium,
                WeeklyMusicWidget(),
                verticalSliverPaddingMedium,
                RecentMusicList(),
                verticalSliverPaddingMedium,
                verticalSliverPaddingMedium
              ],
            ),
          )),
        ],
      ),
    );
  }
}

Widget buildBlurredImage() => ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/Group 5.png',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );

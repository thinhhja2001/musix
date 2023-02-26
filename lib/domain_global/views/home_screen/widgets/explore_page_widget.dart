import 'package:flutter/material.dart';

import 'widgets.dart';

class ExplorePageWidget extends StatelessWidget {
  const ExplorePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTemplateWidget(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              // SizedBox(
              //   height: 24,
              // ),
              // ProfileCardWidget(),
              // SizedBox(
              //   height: 24,
              // ),
              // HubListWidget(
              //   title: 'Topics',
              //   hubs: [],
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // PlaylistListWidget(
              //   playlistArrange: PlaylistArrange.carousel,
              //   sectionPlaylist: SectionPlaylist(
              //     title: 'Recent Album',
              //     items: [],
              //   ),
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // SongListWidget(
              //   songArrange: SongArrange.info,
              //   isScrollable: false,
              //   isShowIndex: true,
              //   sectionSong: SectionSong(
              //     title: 'All Song',
              //     items: [],
              //   ),
              // ),
              // SizedBox(
              //   height: 24,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

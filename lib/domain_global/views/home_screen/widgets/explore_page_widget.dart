import 'package:flutter/material.dart';
import '../../../../domain_music/models/models.dart';

import '../../../../domain_album/models/models.dart';
import '../../../../domain_album/views/widgets.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../domain_user/views/widgets.dart';
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
            children: [
              const SizedBox(
                height: 24,
              ),
              const ProfileCardWidget(),
              const SizedBox(
                height: 24,
              ),
              TopicListWidget(
                title: 'Topics',
                topics: sampleTopicList,
              ),
              const SizedBox(
                height: 24,
              ),
              AlbumListWidget(
                title: 'Recent Album',
                albums: sampleListAlbum,
                isShowAll: false,
              ),
              const SizedBox(
                height: 24,
              ),
              SongListWidget(
                title: 'All Song',
                songs: sampleListSong,
                isShowIndex: true,
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

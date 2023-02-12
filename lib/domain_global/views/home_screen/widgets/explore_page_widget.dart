import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/models.dart';

import '../../../../domain_album/models/models.dart';
import '../../../../domain_album/views/widgets.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../domain_user/views/widgets.dart';
import '../../../../utils/utils.dart';
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
              const Padding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.regular,
                ),
              ),
              const ProfileCardWidget(),
              const SizedBox(
                height: 40,
              ),
              TopicListWidget(
                title: 'Topics',
                topics: sampleTopicList,
              ),
              const SizedBox(
                height: 40,
              ),
              AlbumListWidget(
                title: 'Recent Album',
                albums: sampleListAlbum,
                isShowAll: false,
              ),
              const SizedBox(
                height: 60,
              ),
              SongListWidget(
                title: 'All Song',
                songs: sampleListSong,
                isShowIndex: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

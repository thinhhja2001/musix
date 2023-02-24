import 'package:flutter/material.dart';

import '../../../../domain_hub/views/widgets.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../domain_playlist/views/widgets.dart';
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
            children: const [
              SizedBox(
                height: 24,
              ),
              ProfileCardWidget(),
              SizedBox(
                height: 24,
              ),
              HubListWidget(
                title: 'Topics',
                hubs: [],
              ),
              SizedBox(
                height: 24,
              ),
              PlaylistListWidget(
                title: 'Recent Album',
                playlists: [],
                isShowAll: false,
              ),
              SizedBox(
                height: 24,
              ),
              SongListWidget(
                title: 'All Song',
                songs: [],
                isShowIndex: true,
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

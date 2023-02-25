import 'package:flutter/material.dart';

import '../../../../domain_album/views/widgets.dart';
import '../../../../domain_song/views/widgets.dart';
import '../../../../domain_user/views/widgets/profile_card_widget.dart';
import '../../../../domain_video/models/video_detail_model.dart';
import 'widgets.dart';

class BillboardPageWidget extends StatelessWidget {
  const BillboardPageWidget({Key? key}) : super(key: key);

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
              const AlbumListWidget(
                title: 'New Album',
                playlists: [],
              ),
              const SizedBox(
                height: 32,
              ),
              const SizedBox(
                height: 32,
              ),
              const SongListWidget(
                title: 'Recently Music',
                songs: [],
                isShowIndex: true,
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

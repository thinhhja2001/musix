import 'package:flutter/material.dart';
import 'package:musix/domain_album/views/widgets.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/domain_user/views/widgets/profile_card_widget.dart';

import '../../../../domain_album/models/models.dart';
import '../../../../domain_music/models/models.dart';
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
              AlbumListWidget(
                title: 'New Album',
                albums: sampleListAlbum,
              ),
              const SizedBox(
                height: 32,
              ),
              VideoSelectionWidget(
                title: 'Weekly',
                video: sampleVideo,
              ),
              const SizedBox(
                height: 32,
              ),
              SongListWidget(
                title: 'Recently Music',
                songs: sampleListSong,
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

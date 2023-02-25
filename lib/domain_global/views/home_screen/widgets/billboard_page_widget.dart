import 'package:flutter/material.dart';

import '../../../../domain_hub/entities/entities.dart';
import '../../../../domain_music/models/models.dart';
import '../../../../domain_music/views/widgets.dart';
import '../../../../domain_playlist/views/widgets.dart';
import '../../../../domain_user/views/widgets/profile_card_widget.dart';
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
              const PlaylistListWidget(
                playlistArrange: PlaylistArrange.carousel,
                sectionPlaylist: SectionPlaylist(
                  title: 'New Album',
                ),
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
              const SongListWidget(
                songArrange: SongArrange.info,
                isScrollable: false,
                isShowIndex: true,
                sectionSong: SectionSong(
                  title: 'Recent Song',
                ),
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

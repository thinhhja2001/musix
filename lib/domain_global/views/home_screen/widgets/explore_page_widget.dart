import 'package:flutter/material.dart';
import 'package:musix/domain_global/views/widgets.dart';
import 'package:musix/domain_music/views/widgets.dart';

import '../../../../utils/utils.dart';
import 'widgets.dart';

class ExplorePageWidget extends StatelessWidget {
  const ExplorePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTemplateWidget(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            MusicTypeSelectionWidget(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
            FavoriteWidget(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
            KeepPlaybackWidget(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
            YourPlaylistWidget(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

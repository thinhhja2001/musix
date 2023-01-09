import 'package:flutter/material.dart';
import 'package:musix/domain_album/views/widgets.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/domain_user/views/screens.dart';

import '../../../../utils/utils.dart';
import 'widgets.dart';

class BillboardPageWidget extends StatelessWidget {
  const BillboardPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTemplateWidget(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            ProfileScreen(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
            YouMayLoveAlbumWidget(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
            WeeklyAlbumWidget(),
            Padding(
              padding: EdgeInsets.only(
                top: DistinctConstant.small,
              ),
            ),
            RecentlyMusicWidget(),
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

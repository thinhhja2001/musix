import 'package:flutter/material.dart';
import 'package:musix/domain_album/views/widgets.dart';
import 'package:musix/domain_music/views/widgets.dart';
import 'package:musix/domain_user/views/widgets/profile_card_widget.dart';

import '../../../../utils/utils.dart';
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
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.regular,
                ),
              ),
              ProfileCardWidget(),
              Padding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.small,
                ),
              ),
              NewAlbumWidget(),
              Padding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.small,
                ),
              ),
              WeeklySongWidget(),
              Padding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.small,
                ),
              ),
              RecentlySongWidget(),
              Padding(
                padding: EdgeInsets.only(
                  top: DistinctConstant.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

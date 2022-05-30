import 'package:flutter/material.dart';
import 'package:musix/models/users.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import 'package:musix/widgets/home/profile_card.dart';
import 'package:musix/widgets/music/other/music_type_seclection_widget.dart';

class ExploreWidget extends StatelessWidget {
  const ExploreWidget({
    Key? key,
    required this.user,
  }) : super(key: key);
  final Users user;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      buildBlurredImage(),
      SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: CustomScrollView(
            primary: false,
            slivers: [
              ProfileCard(user: user),
              verticalSliverPaddingMedium,
              SliverToBoxAdapter(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            'Topics',
                            style: kDefaultTitleStyle,
                          )),
                      Expanded(
                        child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: GridView.count(
                                scrollDirection: Axis.horizontal,
                                crossAxisCount: 2,
                                childAspectRatio: 0.5,
                                mainAxisSpacing: 16.0,
                                crossAxisSpacing: 16.0,
                                children: List.generate(
                                    6,
                                    (index) =>
                                        const MusicTypeSelectionWidget()))),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

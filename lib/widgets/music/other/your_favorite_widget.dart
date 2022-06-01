import 'package:flutter/material.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/widgets/list/your_favorite_list.dart';

class YourFavoriteWidget extends StatelessWidget {
  const YourFavoriteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: const [
          RotatedBox(
              quarterTurns: 3,
              child: Text(
                'Your Favorite',
                style: kDefaultTitleStyle,
              )),
          YourFavoriteListWidget(),
        ],
      ),
    );
  }
}

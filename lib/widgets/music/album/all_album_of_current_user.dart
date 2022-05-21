import 'package:flutter/material.dart';
import 'package:musix/utils/enums.dart';
import 'package:musix/widgets/customs/custom_button.dart';
import 'package:musix/widgets/customs/custom_input_field.dart';
import 'package:musix/widgets/music/album/album_summary_card.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class AllAlbumOfCurrentUser extends StatelessWidget {
  const AllAlbumOfCurrentUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(color: kBackgroundColor),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Playlists",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              verticalSpaceSmall,
              Column(
                children: List.generate(5, (index) => const AlbumSummaryCard()),
              ),
              CustomButton(
                  onPress: () {}, content: "Add new Playlist", isLoading: false)
            ],
          ),
        ),
      ),
    );
  }
}

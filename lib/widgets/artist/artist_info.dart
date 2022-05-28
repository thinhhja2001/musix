import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

import '../profile/profile_pic.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo(
      {Key? key,
      required this.thumbnailUrl,
      required this.artistName,
      required this.alias})
      : super(key: key);

  final String thumbnailUrl;
  final String artistName;
  final String alias;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        width: double.infinity,
        height: 20,
      ),
      ProfilePic(
        avatarUrl: thumbnailUrl,
      ),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      Text(
        artistName,
        style: const TextStyle(
            color: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: 16),
      ),
    ]);
  }
}

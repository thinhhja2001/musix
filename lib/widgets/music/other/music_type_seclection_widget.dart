import 'package:flutter/material.dart';
import 'package:musix/utils/constant.dart';

class MusicTypeSelectionWidget extends StatelessWidget {
  const MusicTypeSelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/7/78/Classic_music.jpg'))),
      child: Center(
          child: Text(
        'Classic',
        style: kDefaultHintStyle.copyWith(color: Colors.white, fontSize: 14),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class CurrentMusicPlayer extends StatelessWidget {
  const CurrentMusicPlayer({
    Key? key,
    required this.song,
    required this.singer,
    required this.image,
    required this.borderColor,
  }) : super(key: key);
  final String song;
  final String singer;
  final String image;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(color: borderColor, blurRadius: 4),
                ]),
            child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 25,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(color: borderColor, blurRadius: 4),
                      ]),
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: kBackgroundColorDarker,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song,
                  style: kDefaultTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  singer,
                  style: kDefaultTextStyle.copyWith(
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                verticalSpaceTiny,
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width * 0.42,
                  animation: true,
                  lineHeight: 2,
                  backgroundColor: Colors.white,
                  percent: 0.5,
                  padding: EdgeInsets.zero,
                  progressColor: kPrimaryColor,
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.shuffle,
                  color: Colors.white,
                ),
                RawMaterialButton(
                  onPressed: () {},
                  fillColor: kPrimaryColor,
                  child: const Icon(Icons.pause),
                  shape: const CircleBorder(),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

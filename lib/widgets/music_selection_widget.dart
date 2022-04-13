import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';

class MusicSelectionWidget extends StatelessWidget {
  const MusicSelectionWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Text(
            "#${index + 1}",
            style: kDefaultTitleStyle.copyWith(fontSize: 16),
          ),
          horizontalSpaceSmall,
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: const DecorationImage(
                    image: AssetImage("assets/images/charlie_puth.jpg"),
                    fit: BoxFit.cover)),
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Girl like you",
                      style: kDefaultTitleStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      "Avinci John",
                      style: kDefaultTitleStyle.copyWith(
                          fontSize: 16, color: kPrimaryColor),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: kPrimaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

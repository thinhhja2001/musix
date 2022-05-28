import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

class SearchClassify extends StatelessWidget {
  const SearchClassify(
      {Key? key,
      required this.icon,
      required this.text,
      required this.isClicked})
      : super(key: key);
  final IconData icon;
  final String text;
  final bool isClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 35,
      decoration: BoxDecoration(
          color: isClicked ? kPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        isClicked
            ? Icon(
                icon,
                color: Colors.white,
                size: 20,
              )
            : SizedBox(),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ]),
    );
  }
}

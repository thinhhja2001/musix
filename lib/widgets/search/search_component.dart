import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';
import 'package:musix/utils/constant.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent(
      {Key? key,
      required this.title,
      required this.artist,
      required this.imgLink})
      : super(key: key);
  final String title;
  final String artist;
  final String imgLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imgLink,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  )),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    artist,
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Icon(
                  Icons.play_arrow,
                  color: kPrimaryColor,
                ))
          ],
        ),
      ),
    );
  }
}

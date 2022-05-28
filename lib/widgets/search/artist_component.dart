import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ArtistComponent extends StatelessWidget {
  const ArtistComponent({Key? key, required this.artist, required this.imgLink}) : super(key: key);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    artist,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
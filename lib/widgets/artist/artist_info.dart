import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/utils/colors.dart';

import '../profile/profile_pic.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({
    Key? key, required this.thumbnailUrl, required this.artistName, required this.birthDay,
  }) : super(key: key);

  final String thumbnailUrl;
  final String artistName;
  final String birthDay;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.3,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                thumbnailUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
              height: screenSize.height * 0.2,
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                    thumbnailUrl),
                backgroundColor: Colors.transparent,
              )),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: screenSize.width * 0.6,
                  child: Text(
                    artistName,
                    style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Container(
                width: screenSize.width * 0.6,
                child: Text(
                  birthDay,
                  style: TextStyle(color: kPrimaryColor, fontSize: 15,fontWeight: FontWeight.w700),
                ),
              ),
              ElevatedButton(
                
                onPressed: () {  },
                child: Text("Follow"),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor
                ),
              ),
              SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

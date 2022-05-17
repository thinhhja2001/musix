import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';

import '../../utils/colors.dart';
import '../../utils/constant.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    Key? key,
    required this.album,
  }) : super(key: key);
  final Album album;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: InkWell(
        child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(album.thumbnailUrl))),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(9)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                album.title,
                                overflow: TextOverflow.ellipsis,
                                style: kDefaultTextStyle.copyWith(
                                    fontWeight: FontWeight.w400, fontSize: 16),
                              ),
                              Text(
                                album.artistNames,
                                overflow: TextOverflow.ellipsis,
                                style: kDefaultTextStyle.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: kPrimaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

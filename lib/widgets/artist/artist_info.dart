import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/resources/artist_methods.dart';
import 'package:musix/resources/general_music_methods.dart';
import 'package:musix/utils/colors.dart';

import '../profile/profile_pic.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({
    Key? key,
    required this.thumbnailUrl,
    required this.artistName,
    required this.birthDay,
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
            image: NetworkImage(thumbnailUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 5,
          ),
          Container(
              padding: const EdgeInsets.only(top: 10.0),
              height: screenSize.height * 0.2,
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(thumbnailUrl),
                backgroundColor: Colors.transparent,
              )),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: screenSize.width * 0.6,
                  child: Text(
                    artistName,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.6,
                child: Text(
                  birthDay,
                  style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ),
              ),
              _AddArtistToFavoriteButton(artistName: artistName),
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddArtistToFavoriteButton extends StatelessWidget {
  const _AddArtistToFavoriteButton({
    Key? key,
    required this.artistName,
  }) : super(key: key);
  final String artistName;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: GeneralMusicMethods.getAllFavoriteObject(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List favoriteArtists = snapshot.data!.get('artists');
            return ElevatedButton(
              onPressed: () async {
                await ArtistMethods.onFavoriteArtistClickHandler(artistName);
              },
              child: favoriteArtists.contains(artistName)
                  ? Row(
                      children: const [Text("Following"), Icon(MdiIcons.check)],
                    )
                  : Row(children: const [Text("Follow"), Icon(MdiIcons.plus)]),
              style: ElevatedButton.styleFrom(primary: kPrimaryColor),
            );
          }
          return Container();
        });
  }
}

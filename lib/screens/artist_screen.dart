import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/providers/artist_provider.dart';
import 'package:musix/widgets/artist/artist_info.dart';
import 'package:musix/widgets/artist/artist_songs.dart';
import 'package:musix/widgets/search/artist_component.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({Key? key, required this.artist}) : super(key: key);

  final Map<String, dynamic> artist;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    ArtistProvider artistProvider = Provider.of<ArtistProvider>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Artist information"),
        backgroundColor: kBackgroundColorDarker,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ArtistInfo(
              artistName: widget.artist['name'],
              thumbnailUrl: widget.artist['thumbnailUrl'],
              alias: widget.artist['alias'],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "All songs",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            artistProvider.loading
                ? CircularProgressIndicator()
                : ArtistSongs(componentList: artistProvider.songList),
          ],
        ),
      ),
    );
  }
}

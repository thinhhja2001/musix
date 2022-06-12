import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/providers/artist_provider.dart';
import 'package:musix/providers/custom_bottom_bar_provider.dart';
import 'package:musix/screens/album_screen_by_song_type.dart';
import 'package:musix/widgets/artist/artist_description.dart';
import 'package:musix/widgets/artist/artist_info.dart';
import 'package:musix/widgets/artist/artist_list_songs.dart';
import 'package:musix/widgets/artist/artist_songs.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../widgets/search/search_album.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final Map<String, dynamic> artist;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  @override
  Widget build(BuildContext context) {
    ArtistProvider artistProvider = Provider.of<ArtistProvider>(context);
    CustomBottomBarProvider customBottomBarProvider =
        Provider.of<CustomBottomBarProvider>(context);
    return Scaffold(
      bottomNavigationBar: customBottomBarProvider.customBottomBar,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text("Artist information"),
      ),
      body: SingleChildScrollView(
        child: artistProvider.loading
            ? const Center(
                child: CircularProgressIndicator(
                color: kPrimaryColor,
              ))
            : Column(
                children: [
                  ArtistInfo(
                    artistName: widget.artist['name'],
                    thumbnailUrl: widget.artist['thumbnailUrl'],
                    birthDay: artistProvider.artist['birthDay'],
                  ),
                  ArtistDesc(description: artistProvider.artist['biography']),
                  const SizedBox(
                    height: 20,
                  ),
                  ArtistListSong(),
                  const SizedBox(
                    height: 20,
                  ),
                  SearchAlbum(albumList: artistProvider.albumList),
                  TextButton(
                      onPressed: () => Get.to(AllAlbumByNameScreen(
                          name: widget.artist['name'], quantity: 50)),
                      child: const Text(
                        "View all album",
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/song.dart';
import 'package:musix/utils/utils.dart';

class SongMethods {
  static Future<Song> getSongDataByKey(String songKey) async {
    Map<String, dynamic> songData = await ZingMP3API.getSongDataByKey(songKey);
    return Song.fromJson(songData);
  }

  static Future<List<Song>> getListSongDataByKeys(List<String> songKeys) async {
    List<Song> songs = List.empty(growable: true);
    for (var i = 0; i < songKeys.length; i++) {
      Map<String, dynamic> songData =
          await ZingMP3API.getSongDataByKey(songKeys[i]);
      Song song = Song.fromJson(songData);
      songs.add(song);
    }
    return songs;
  }

  ///Get all list album by favorite artist of current user
  static Future<List<Album>> getListAlbumByArtists(List<String> artists) async {
    List<Album> albums = List.empty(growable: true);
    for (var artist in artists) {
      List<Map<String, dynamic>> albumsData =
          await ZingMP3API.getListAlbumDataByName(artist, 1);
      Map<String, dynamic> albumData = albumsData[0];
      Album album = Album.fromJson(albumData);
      albums.add(album);
    }
    albums = albums.toSet().toList();
    return albums;
  }

  static Future<List> getAllFavoriteSong() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    try {
      final music = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('favorites')
          .get();
      return music['songs'];
    } catch (e) {
      return [];
    }
  }

  static void _removeSongFromFavorite(String songId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    List allFavoriteSongs = await getAllFavoriteSong();
    allFavoriteSongs.remove(songId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .update({'songs': allFavoriteSongs});
  }

  static void _addSongToFavorite(String songId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    List allFavoriteSongs = await getAllFavoriteSong();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .update({
      'songs': [...allFavoriteSongs, songId]
    });
  }

  static Future<String> onFavoriteSongClickHandler(Song song) async {
    String result = "";
    List allFavoriteSongs = await getAllFavoriteSong();

    if (allFavoriteSongs.contains(song.id)) {
      _removeSongFromFavorite(song.id);
      result = 'remove';
    } else {
      _addSongToFavorite(song.id);
      result = 'added';
    }

    showCompleteNotification(
        title: song.name,
        message: result == 'added'
            ? "Has been added to your favorite"
            : 'Has been removed from your favorite list',
        icon: result == 'added' ? MdiIcons.heart : MdiIcons.heartBroken);
    return result;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/models/album.dart';
import 'package:musix/utils/utils.dart';
import '../models/song.dart';

class PlaylistMethods {
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

  ///This method is only use when user have no favorite song.
  static void _createFavoriteList(String songId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .set({
      'songs': [songId]
    });
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
        .set({'songs': allFavoriteSongs});
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

  static Future<String> createPlaylist(String name, Song song) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    String result = "";
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('customPlaylists')
          .set({});
      final document = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('customPlaylists')
          .collection('allCustomPlaylist')
          .doc();
      final album = Album(
          id: document.id,
          songs: [song.id],
          title: name,
          artistNames: 'artistNames',
          artistLink: 'artistLink',
          thumbnailUrl: song.thumbnailUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('customPlaylists')
          .collection('allCustomPlaylist')
          .doc(document.id)
          .set(album.toJson());
      result = 'success';
      showCompleteNotification(
          title: song.name,
          message: 'Has been added to $name',
          icon: MdiIcons.check);
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  static Future<String> onFavoriteClickHandler(Song song) async {
    String result = "";
    List allFavoriteSongs = await getAllFavoriteSong();
    if (allFavoriteSongs.isEmpty) {
      _createFavoriteList(song.id);
      result = 'added';
    } else {
      if (allFavoriteSongs.contains(song.id)) {
        _removeSongFromFavorite(song.id);
        result = 'remove';
      } else {
        _addSongToFavorite(song.id);
        result = 'added';
      }
    }

    showCompleteNotification(
        title: song.name,
        message: result == 'added'
            ? "Has been added to your favorite"
            : 'Has been removed from your favorite list',
        icon: result == 'added' ? MdiIcons.heart : MdiIcons.heartBroken);
    return result;
  }

  static Future<List<Album>> getAllAlbumOfCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    List<Album> albums = List.empty(growable: true);
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('customPlaylists')
        .collection('allCustomPlaylist')
        .get();

    for (var i = 0; i < snapshot.docs.length; i++) {
      final data = snapshot.docs.elementAt(i).data();
      final Album album = Album.fromJson(data);
      albums.add(album);
    }
    return albums;
  }
}

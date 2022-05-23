import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musix/utils/utils.dart';
import 'package:flutter/material.dart';
import '../models/song.dart';

class FirebaseHandler {
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
        icon: Icons.favorite);
    return result;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';

class ArtistMethods {
  static Future<List> getAllFavoriteArtist() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    try {
      final music = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('favorites')
          .get();
      return music['artists'];
    } catch (e) {
      return [];
    }
  }

  static Future<List> getTop10FavoriteArtists() async {
    List favoriteArtists = await getAllFavoriteArtist();
    List shortageFavoriteArtists = List.empty(growable: true);
    if (favoriteArtists.isEmpty) {
      return fakeFavoriteArtists;
    } else {
      for (var i = 0; i < favoriteArtists.length; i++) {
        if (shortageFavoriteArtists.length < 10) {
          shortageFavoriteArtists.add(favoriteArtists.elementAt(i));
        } else {
          break;
        }
      }
    }
    return shortageFavoriteArtists;
  }

  static void _addArtistToFavorite(String artistName) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    List favoriteArtists = await getAllFavoriteArtist();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .update({
      'artists': [...favoriteArtists, artistName]
    });
  }

  static void _removeArtistFromFavorite(String artistName) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    List favoriteArtists = await getAllFavoriteArtist();
    favoriteArtists.remove(artistName);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .update({'artists': favoriteArtists});
  }

  static Future<String> onFavoriteArtistClickHandler(String artistName) async {
    String result = "";
    List favoriteArtists = await getAllFavoriteArtist();
    if (favoriteArtists.contains(artistName)) {
      _removeArtistFromFavorite(artistName);
      result = "deleted";
    } else {
      _addArtistToFavorite(artistName);
      result = "added";
    }
    showCompleteNotification(
        title: artistName,
        message: result == 'added'
            ? "You are now following $artistName"
            : "You have unfollow $artistName",
        icon: result == 'added' ? MdiIcons.heart : MdiIcons.heartBroken);
    return result;
  }
}

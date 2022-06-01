import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/song.dart';
import 'package:musix/utils/utils.dart';

class SongMethods {
  static Future<Song> getSongDataByKey(String songKey) async {
    Map<String, dynamic> songData = await ZingMP3API.getSongDataByKey(songKey);
    return Song.fromJson(songData);
  }

  static Future<List<Song>> getListSongDataByKeys(List songKeys) async {
    List<Song> songs = List.empty(growable: true);
    for (var i = 0; i < songKeys.length; i++) {
      Map<String, dynamic> songData =
          await ZingMP3API.getSongDataByKey(songKeys[i]);
      Song song = Song.fromJson(songData);
      songs.add(song);
    }
    return songs;
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

  static Future<List<String>> getRecentListenedSong(
      {required int quantity}) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    List<String> songKeys = List.empty(growable: true);
    final songsData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('songs')
        .orderBy('lastHear', descending: true)
        .limit(quantity)
        .get();
    for (var songData in songsData.docs) {
      songKeys.add(songData.id);
    }
    return songKeys;
  }

  static Future<List<dynamic>> getTopListenedSongOrderByListenTime(
      {required int quantity}) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    List songKeys = List.empty(growable: true);
    final songsData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('songs')
        .orderBy('listenTime', descending: true)
        .limit(quantity)
        .get();
    for (var songData in songsData.docs) {
      songKeys.add(songData.id);
    }
    return songKeys;
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

  static Future getAllListenedSong() async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    final songs = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('songs')
        .get();
    return songs;
  }

  static Future<void> addSongToListenHistory(Song currentSong) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .set({});
    final songs = await getAllListenedSong();
    for (var doc in songs.docs) {
      if (doc.id == currentSong.id) {
        _updateListenTime(currentSong);
        return;
      }
    }
    _setNewSongToListenHistory(currentSong);
  }

  static Future<void> _setNewSongToListenHistory(Song currentSong) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('songs')
        .doc(currentSong.id)
        .set({'listenTime': 1, 'lastHear': DateTime.now()});
  }

  static Future<void> _updateListenTime(Song currentSong) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    final song = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('songs')
        .doc(currentSong.id)
        .get();
    int listenTime = song.data()!['listenTime'];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('songs')
        .doc(currentSong.id)
        .update({'listenTime': ++listenTime, 'lastHear': DateTime.now()});
  }
}

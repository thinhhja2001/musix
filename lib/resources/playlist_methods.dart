import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/utils.dart';
import '../models/song.dart';

class PlaylistMethods {
  static Future<Album> getAlbumDataByKey(String albumKey) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    late Map<String, dynamic> albumData;
    if (isOfficialAlbum(albumKey)) {
      albumData = await ZingMP3API.getAlbumDataByKey(albumKey);
    } else {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('customPlaylists')
          .collection('allCustomPlaylist')
          .doc(albumKey)
          .get();
      albumData = snapshot.data()!;
    }
    return Album.fromJson(albumData);
  }

  static Future<Album> getTopListenTimeSongPlaylist(
      {required int quantity}) async {
    List songs = await SongMethods.getTopListenedSongOrderByListenTime(
        quantity: quantity);
    return Album(
        id: unfavorable,
        songs: songs,
        title: 'Never Enough',
        artistNames: 'Various Artists',
        artistLink: '',
        thumbnailUrl:
            'https://play-lh.googleusercontent.com/gGHaWnV9n3EK0jpJ_yessWA1PF6mcL7Ys41mBPTCTXtusf13Yr2zVpVYAOI69ZX2Gjc');
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
          artistNames: 'Various Artists',
          artistLink: '',
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

  static Future<String> addSongToExistedPlaylist(Song song, Album album) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    String result = "";
    final albumData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('customPlaylists')
        .collection('allCustomPlaylist')
        .doc(album.id)
        .get();
    List songs = albumData['songs'];
    songs.add(song.id);
    songs = songs.toSet().toList();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('customPlaylists')
        .collection('allCustomPlaylist')
        .doc(album.id)
        .update({'songs': songs});

    showCompleteNotification(
        title: song.name,
        message: 'Has been added to ${album.title}',
        icon: MdiIcons.check);
    return result;
  }

  static Future<List> getAllFavoriteAlbumOfCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    try {
      final music = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('playlists')
          .doc('favorites')
          .get();
      return music['albums'];
    } catch (e) {
      return [];
    }
  }

  static void _removeAlbumFromFavorite(String albumId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    List allFavoriteAlbums = await getAllFavoriteAlbumOfCurrentUser();
    allFavoriteAlbums.remove(albumId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .update({'albums': allFavoriteAlbums});
  }

  static void _addAlbumToFavorite(String albumId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    List allFavoriteAlbums = await getAllFavoriteAlbumOfCurrentUser();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('favorites')
        .update({
      'albums': [...allFavoriteAlbums, albumId]
    });
  }

  static Future<String> onFavoriteAlbumClickHandler(Album album) async {
    String result = "";
    List allFavoriteAlbums = await getAllFavoriteAlbumOfCurrentUser();
    if (allFavoriteAlbums.contains(album.id)) {
      _removeAlbumFromFavorite(album.id);
      result = 'removed';
    } else {
      _addAlbumToFavorite(album.id);
      result = 'added';
    }
    showCompleteNotification(
        title: album.title,
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

  static Album getFavoriteSongPlaylist(DocumentSnapshot snapshot) {
    final album = Album(
        id: unfavorable,
        songs: snapshot.get('songs'),
        title: 'Favorite songs',
        artistNames: 'Various Artists',
        artistLink: '',
        thumbnailUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI6f-ExylkpwX5V7FbtITtoiJyWk-8-jfKB-O1BBz_2fPEOg6a_ywGHfZaIvFdlDvCNfY&usqp=CAU');
    return album;
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

  static Future<QuerySnapshot<Map<String, dynamic>>>
      getAllListenedAlbums() async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    final albums = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('albums')
        .get();

    return albums;
  }

  static Future<List<dynamic>> getTopListenedAlbumOrderByListenTime(
      {required int quantity}) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    List albumKeys = List.empty(growable: true);
    final albumsData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('albums')
        .orderBy('listenTime', descending: true)
        .limit(quantity)
        .get();
    for (var albumData in albumsData.docs) {
      albumKeys.add(albumData.id);
    }
    return albumKeys;
  }

  static Future<void> addAlbumToListenHistory(Album currentAlbum) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .set({});
    final albums = await getAllListenedAlbums();
    for (var doc in albums.docs) {
      if (doc.id == currentAlbum.id) {
        _updateListenTime(currentAlbum);
        return;
      }
    }
    _setNewAlbumToListenHistory(currentAlbum);
  }

  static Future<void> _setNewAlbumToListenHistory(Album currentAlbum) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('albums')
        .doc(currentAlbum.id)
        .set({'listenTime': 1, 'lastHear': DateTime.now()});
  }

  static Future<void> _updateListenTime(Album currentAlbum) async {
    final currentUser = FirebaseAuth.instance.currentUser!;

    final album = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('albums')
        .doc(currentAlbum.id)
        .get();
    int listenTime = album.data()!['listenTime'];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('playlists')
        .doc('listenHistory')
        .collection('albums')
        .doc(currentAlbum.id)
        .update({'listenTime': ++listenTime, 'lastHear': DateTime.now()});
  }
}

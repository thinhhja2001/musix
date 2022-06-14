import 'package:flutter/material.dart';
import 'package:musix/apis/last_fm_api.dart';
import 'package:musix/apis/zing_mp3_api.dart';

import '../models/song.dart';

class ArtistProvider with ChangeNotifier {
  List<Map<String, dynamic>> _songList = List.empty(growable: true);
  List<Map<String, dynamic>> _albumList = List.empty(growable: true);
  Map<String, dynamic> _artist = {};
  bool _loading = false;

  List<Song> _artistSongs = List.empty(growable: true);

  get artistSongs => _artistSongs;
  get loading => _loading;

  get songList => _songList;
  get albumList => _albumList;
  get artist => _artist;

  void getData(String name) async {
    _loading = true;
    _songList = List.empty(growable: true);
    _albumList = List.empty(growable: true);
    notifyListeners();
    String artistName = name.replaceAll(' ', '+');
    print(artistName);
    await LastFmAPI.getArtistDetailByName(artistName).then((value) {
      _artist = value;
      notifyListeners();
      getArtistSongs().then((value) {
        _songList = value;
        if (_albumList.isNotEmpty) {
          _loading = false;
          notifyListeners();
        }
      });
      getArtistAlbums().then((value) {
        _albumList = value;
        if (_songList.isNotEmpty) {
          _loading = false;
          notifyListeners();
        }
      });
    });
  }

  Future<List<Map<String, dynamic>>> getArtistSongs() async {
    List<Map<String, dynamic>> songs = List.empty(growable: true);
    _artistSongs = List.empty(growable: true);
    for (int i = 0; i < 5; i++) {
      try {
        await ZingMP3API.getSongDataByKey(_artist['songsKey'][i]).then((value) {
          songs.add(value);
          Song song = Song(
              id: songs[i]['id'],
              name: songs[i]['name'],
              audioUrl: songs[i]['audioUrl'],
              lyricUrl: songs[i]['lyricUrl'],
              artistName: songs[i]['artistName'],
              artistLink: songs[i]['artistLink'],
              thumbnailUrl: songs[i]['thumbnailUrl']);
          _artistSongs.add(song);
        });
      } catch (e) {
        _loading = false;
        notifyListeners();
        break;
      }
    }
    return songs;
  }

  Future<List<Map<String, dynamic>>> getArtistAlbums() async {
    List<Map<String, dynamic>> albums = List.empty(growable: true);
    for (int i = 0; i < 5; i++) {
      await ZingMP3API.getAlbumDataByKey(_artist['albumsKey'][i]).then((value) {
        albums.add(value);
      });
    }
    return albums;
  }
}

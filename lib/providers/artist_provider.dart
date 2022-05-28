import 'package:flutter/material.dart';
import 'package:musix/apis/last_fm_api.dart';
import 'package:musix/apis/zing_mp3_api.dart';

class ArtistProvider with ChangeNotifier {
  List<Map<String, dynamic>> _songList = List.empty(growable: true);
  List<Map<String, dynamic>> _albumList = List.empty(growable: true);
  Map<String, dynamic> _artist = {};
  bool _loading = false;

  get songList => _songList;
  get albumList => _albumList;
  get artist => _artist;
  bool get loading => _loading;

  void getData(String name) async {
    _loading = true;
    notifyListeners();
    String artistName = name.replaceAll(' ', '+');
    print(artistName);
    await LastFmAPI.getArtistDetailByName(artistName).then((value) {
      _artist = value;
      getArtistSongs().then((value) {
        print(value);
        _songList = value;
        _loading = false;
        notifyListeners();
      });
    });
  }

  Future<List<Map<String, dynamic>>> getArtistSongs() async {
    List<Map<String, dynamic>> songs = List.empty(growable: true);
    for (int i = 0; i < _artist['songsKey'].length; i++) {
      await ZingMP3API.getSongDataByKey(_artist['songsKey'][i]).then((value) {
        songs.add(value);
      });
    }
    return songs;
  }
}

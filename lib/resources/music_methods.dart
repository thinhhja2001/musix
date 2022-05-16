import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/song.dart';

class MusicMethods {
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
}

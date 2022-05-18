import 'package:musix/apis/zing_mp3_api.dart';
import 'package:musix/models/album.dart';
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
}

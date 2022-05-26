import 'package:musix/apis/web_scraper_api.dart';
import 'package:musix/apis/zing_mp3_api.dart';

class Album {
  String id;
  List songs;
  String title;
  String artistNames;
  String artistLink;
  String thumbnailUrl;
  Album(
      {required this.id,
      required this.songs,
      required this.title,
      required this.artistNames,
      required this.artistLink,
      required this.thumbnailUrl});
  static fromJson(Map<String, dynamic> albumData) {
    return Album(
        id: albumData['id'],
        songs: albumData['songs'],
        title: albumData['title'],
        artistNames: albumData['artistNames'],
        artistLink: albumData['artistLink'],
        thumbnailUrl: albumData['thumbnailUrl']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "songs": songs,
        "title": title,
        "artistNames": artistNames,
        "artistLink": artistLink,
        "thumbnailUrl": thumbnailUrl,
      };
  static Future<Album> topSongVietnam() async {
    List<String> songs = await ZingMP3API.getAllTopVPOPSongKey();
    String thumbnailUrl =
        await WebScraperApi.getThumbnailUrl('/playlist/hot-hits-vietnam');
    return Album(
        id: 'vn',
        songs: songs,
        title: 'Top V-POP',
        artistNames: 'Various Artist',
        artistLink: 'artistLink',
        thumbnailUrl: thumbnailUrl);
  }

  static Future<Album> topSongUSUK() async {
    List<String> songs = await ZingMP3API.getAllTopUSUKSongKey();
    String thumbnailUrl =
        await WebScraperApi.getThumbnailUrl('/playlist/hot-hits-us');
    return Album(
        id: 'usuk',
        songs: songs,
        title: 'Top USUK',
        artistNames: 'Various Artist',
        artistLink: 'artistLink',
        thumbnailUrl: thumbnailUrl);
  }

  static Future<Album> topSongKPOP() async {
    List<String> songs = await ZingMP3API.getAllTopKpopSongKey();
    String thumbnailUrl =
        await WebScraperApi.getThumbnailUrl('/playlist/hot-hits-korea');
    return Album(
        id: 'kpop',
        songs: songs,
        title: 'Top KPOP',
        artistNames: 'Various Artist',
        artistLink: 'artistLink',
        thumbnailUrl: thumbnailUrl);
  }

  @override
  String toString() {
    return "$id $songs $title $artistNames $artistLink $thumbnailUrl";
  }
}

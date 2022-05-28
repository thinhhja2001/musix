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
    Album album =
        Album.fromJson(await ZingMP3API.getAlbumDataByKey('ZWZB969E'));
    String thumbnailUrl =
        await WebScraperApi.getThumbnailUrl('/playlist/hot-hits-vietnam');
    return Album(
        id: album.id,
        songs: album.songs,
        title: 'Top 100 V-POP',
        artistNames: 'Various Artist',
        artistLink: 'artistLink',
        thumbnailUrl: thumbnailUrl);
  }

  static Future<Album> topSongUSUK() async {
    Album album =
        Album.fromJson(await ZingMP3API.getAlbumDataByKey('ZWZB96AB'));
    String thumbnailUrl =
        await WebScraperApi.getThumbnailUrl('/playlist/hot-hits-us');
    return Album(
        id: album.id,
        songs: album.songs,
        title: 'Top 100 USUK',
        artistNames: 'Various Artist',
        artistLink: 'artistLink',
        thumbnailUrl: thumbnailUrl);
  }

  static Future<Album> topSongKPOP() async {
    Album album =
        Album.fromJson(await ZingMP3API.getAlbumDataByKey('ZWZB96DC'));
    String thumbnailUrl =
        await WebScraperApi.getThumbnailUrl('/playlist/hot-hits-korea');
    return Album(
        id: album.id,
        songs: album.songs,
        title: 'Top 100 KPOP',
        artistNames: 'Various Artist',
        artistLink: 'artistLink',
        thumbnailUrl: thumbnailUrl);
  }

  @override
  String toString() {
    return "$id $songs $title $artistNames $artistLink $thumbnailUrl";
  }
}

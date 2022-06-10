import 'dart:convert';

import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;

class LastFmAPI {
  ///Get all song Key by Artist name
  ///
  ///[artistName] is stand for artistName
  static Future<List<String>> _getAllSongKeyByArtistName(
      String artistName) async {
    List<String> songsKey = List.empty(growable: true);
    String query =
        "http://ac.mp3.zing.vn/complete?type=song&num=5&query=$artistName";
    final response = await http.get(Uri.parse(query));
    Map<String, dynamic> responseInJson = json.decode(response.body);
    int responseLength = 0;
    while (responseLength >= 0) {
      try {
        responseInJson['data'][0]['song'][responseLength];
        responseLength++;
      } catch (e) {
        break;
      }
    }
    for (var i = 0; i < responseLength; i++) {
      String songKey = responseInJson['data'][0]['song'][i]['id'];
      songsKey.add(songKey);
    }
    return songsKey;
  }

  ///Get all album key by artistName
  ///
  ///[artistName] is stand for artistName
  static Future<List<String>> _getAllAlbumKeyByArtistName(
      String artistName) async {
    List<String> albumsKey = List.empty(growable: true);
    String query =
        "http://ac.mp3.zing.vn/complete?type=album&num=10&query=$artistName";
    final response = await http.get(Uri.parse(query));
    Map<String, dynamic> responseInJson = json.decode(response.body);
    int responseLength = 0;
    while (responseLength >= 0) {
      try {
        responseInJson['data'][0]['album'][responseLength];
        responseLength++;
      } catch (e) {
        break;
      }
    }
    for (var i = 0; i < responseLength; i++) {
      String albumKey = responseInJson['data'][0]['album'][i]['id'];
      albumsKey.add(albumKey);
    }
    return albumsKey;
  }

  ///Get artist detail by name
  ///[name] represents for artistName
  ///This method is use in showing detail page of an artist like
  ///https://zingmp3.vn/nghe-si/Taylor-Swift
  static Future<Map<String, dynamic>> getArtistDetailByName(String name) async {
    final webScraper = WebScraper('https://www.last.fm/');
    String imageUrl = "";
    String birthDay = "";
    String biography = "";
    String artistName = "";
    if (await webScraper.loadWebPage("music/$name/+wiki")) {
      List<Map<String, dynamic>> artistNameElement =
          webScraper.getElement("h1.header-new-title", ['src']);
      artistName = artistNameElement[0]['title'];
      List<Map<String, dynamic>> imageElement =
          webScraper.getElement('div.header-new-background-image', ['content']);

      imageElement.isNotEmpty
          ? imageUrl = imageElement[0]['attributes']['content'] ?? ""
          : imageUrl =
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png";

      List<Map<String, dynamic>> birthDayElement = webScraper
          .getElement("div.wiki-container > ul > li:nth-child(1) > p", ['']);
      birthDayElement.isNotEmpty
          ? birthDay = birthDayElement[0]['title'] ?? ""
          : birthDay = "";

      List<Map<String, dynamic>> biographyElement = webScraper.getElement(
          " div.col-main > div > div.wiki-container > div.wiki > div > p",
          ['']);
      for (var i = 0; i < biographyElement.length; i++) {
        biography += biographyElement[i]['title'] + "\n" ?? "";
      }
    }
    final songsKey = await _getAllSongKeyByArtistName(artistName);
    final albumsKey = await _getAllAlbumKeyByArtistName(artistName);
    return {
      'name': artistName,
      'imageUrl': imageUrl,
      'birthDay': birthDay,
      'biography': biography,
      'songsKey': songsKey,
      'albumsKey': albumsKey
    };
  }
}

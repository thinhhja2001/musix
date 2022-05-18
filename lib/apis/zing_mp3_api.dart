import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class ZingMP3API {
  ///Get website Html code
  ///
  ///[websiteUrl] stand for the website you want to get its HTML code
  static Future<dom.Document> _getWebsiteHtmlCode(String websiteUrl) async {
    final url = Uri.parse(websiteUrl);
    final response = await http.get(url);
    String responseBody = utf8.decoder.convert(response.bodyBytes);
    dom.Document html = dom.Document.html(responseBody);
    return html;
  }

  ///Get all data of [songKey] in JSon format.
  ///
  ///For example https://mp3.zing.vn/xhr/media/get-source?type=audio&key=LHJmtkmazDApWBmtHTDnLHykCQLgAzzFd
  static Future<Map<String, dynamic>> _getSongDataFromZingMp3(
      String songKey) async {
    dom.Document html =
        await _getWebsiteHtmlCode("https://zingmp3.vn/link/song/$songKey");
    final musicLink =
        html.head!.getElementsByTagName('link')[0].attributes['href'];

    html = await _getWebsiteHtmlCode(musicLink.toString());
    final musicDataSource =
        html.getElementById('zplayerjs-wrapper')!.attributes['data-source'];
    String url = "http://mp3.zing.vn/xhr$musicDataSource";
    final response = await http.get(Uri.parse(url));
    final responseInJson = json.decode(response.body);
    return responseInJson;
  }

  ///Get all data of [videoKey] in JSon format.
  ///
  ///For example https://mp3.zing.vn/xhr/media/get-source?type=video&key=kmxHyZmNpdlNZzSyHyvnLHyZCWZJdaCCm
  static Future<Map<String, dynamic>> _getVideoDataFromZingMp3(
      String videoKey) async {
    dom.Document html =
        await _getWebsiteHtmlCode("https://zingmp3.vn/link/video/$videoKey");
    final musicLink =
        html.head!.getElementsByTagName('link')[0].attributes['href'];

    html = await _getWebsiteHtmlCode(musicLink.toString());
    final musicDataSource =
        html.getElementById('zplayerjs-wrapper')!.attributes['data-source'];
    String url = "http://mp3.zing.vn/xhr$musicDataSource";
    final response = await http.get(Uri.parse(url));
    final responseInJson = json.decode(response.body);
    return responseInJson;
  }

  ///Get ZingMP3 song data by [songKey]. [songKey] is required otherwise it can't be get.
  ///
  ///For example https://zingmp3.vn/bai-hat/Hue-Tinh-Yeu-Cua-Toi-Quang-Le/ZW6I00IA.html then 'ZW6I00IA' is [songKey]
  ///
  ///Please note that this can't get VIP song in ZingMP3
  static Future<Map<String, dynamic>> getSongDataByKey(String songKey) async {
    Map<String, dynamic> musicData = await _getSongDataFromZingMp3(songKey);
    String audioUrl = "";
    String lyricUrl = "";
    String songName = "";
    String artistName = "";
    String thumbnailUrl = "";
    String songId = "";
    String artistLink = "";

    songName = musicData['data']['name'];
    songId = musicData['data']['id'];
    lyricUrl = musicData['data']['lyric'];
    thumbnailUrl = musicData['data']['thumbnail'];
    artistName = musicData['data']['artist']['name'];
    artistLink = "https://mp3.zing.vn" + musicData['data']['artist']['link'];
    audioUrl = musicData['data']['source']['128'] ?? "";

    return {
      'id': songId,
      'name': songName,
      'audioUrl': audioUrl,
      'lyricUrl': lyricUrl,
      'artistName': artistName,
      'artistLink': artistLink,
      'thumbnailUrl': thumbnailUrl
    };
  }

  /// Get all song data by name.
  /// Return the first 5 song that match the name by default.
  ///
  /// [songName] represent for the name of the song you want to find
  /// [quantity] represent for the number of song you want to find. Its default value is 5
  ///
  /// Please note that the return List's length might be < [quantity] depends on the returned JSon Array
  ///
  /// Song audio which require VIP to access won't be able to get.
  /// Because of that, audioUrl of the song which require VIP to access will have value of ' '
  static Future<List<Map<String, dynamic>>> getListSongDataByName(
      String songName,
      [int quantity = 5]) async {
    List<Map<String, dynamic>> songsData = List.empty(growable: true);
    String query =
        "http://ac.mp3.zing.vn/complete?type=song&num=$quantity&query=$songName";
    final response = await http.get(Uri.parse(query));
    final Map<String, dynamic> responseInJson = json.decode(response.body);

    int responseLength = 0;
    while (responseLength >= 0) {
      try {
        responseInJson['data'][0]['song'][responseLength]['id'];
        responseLength++;
      } catch (e) {
        break;
      }
    }

    for (var i = 0; i < responseLength; i++) {
      String songKey = responseInJson['data'][0]['song'][i]['id'];
      Map<String, dynamic> songData = await getSongDataByKey(songKey);
      songsData.add(songData);
    }
    return songsData;
  }

  ///Get ZingMP3 album data by [albumKey]. [albumKey] is required otherwise it can't be get.
  ///
  ///For example https://zingmp3.vn/album/Nhung-Bai-Hat-Hay-Nhat-Cua-BLACKPINK-BLACKPINK/ZOZ9UA7E.html then 'ZOZ9UA7E' is [albumKey]
  ///
  ///Please note that this can't get VIP song in ZingMP3
  static Future<Map<String, dynamic>> getAlbumDataByKey(String albumKey) async {
    dom.Document html =
        await _getWebsiteHtmlCode("https://zingmp3.vn/link/album/$albumKey");
    var albumLink =
        html.head!.getElementsByTagName('link')[0].attributes['href'];
    albumLink = albumLink?.substring(21);
    html = await _getWebsiteHtmlCode("https://mp3.zing.vn/$albumLink");
    final albumDataSource =
        html.getElementById("zplayerjs-wrapper")!.attributes['data-xml'];
    String url = "http://mp3.zing.vn/xhr$albumDataSource";
    final response = await http.get(Uri.parse(url));
    final responseInJson = json.decode(response.body);

    ///Get total number of songs in album
    int albumSongCount = 0;
    while (albumSongCount >= 0) {
      try {
        responseInJson['data']['items'][albumSongCount];
        albumSongCount++;
      } catch (e) {
        ///Since I don't know how to parse JSon array to array, I use this way to get JSon Array length.
        ///
        ///Basically, it will try to increase the [albumSongCount]
        ///until the value that responseInJson['data']['items'][albumSongCount]
        ///return null which means it reach the end of the array
        break;
      }
    }
    List<String> songsKeys = List.empty(growable: true);
    for (var i = 0; i < albumSongCount; i++) {
      final songKeys = responseInJson['data']['items'][i]['id'];
      songsKeys.add(songKeys);
    }
    //Since album with multi artist in will cause trouble as there will be no artistLink
    String artistLink;
    try {
      artistLink = "https://mp3.zing.vn" +
          responseInJson['data']['info']['artists'][0]['link'];
    } catch (e) {
      artistLink = "";
    }
    return {
      'id': responseInJson['data']['info']['id'],
      'songs': songsKeys,
      'title': responseInJson['data']['info']['title'],
      'artistNames': responseInJson['data']['info']['artists_names'],
      'artistLink': artistLink,
      'thumbnailUrl': responseInJson['data']['info']['thumbnail_medium'],
    };
  }

  /// Get all album data by name.
  /// Return the first 5 album that match the name by default.
  ///
  /// [albumName] represent for the name of the album you want to find
  /// [quantity] represent for the number of album you want to find. Its default value is 5
  ///
  /// Please note that the returned List's length might be < [quantity] depends on the returned JSon Array
  ///
  /// Song audio which require VIP to access won't be able to get.
  /// Because of that, audioUrl of the song which require VIP to access will have value of ' '
  static Future<List<Map<String, dynamic>>> getListAlbumDataByName(
      String albumName,
      [int quantity = 5]) async {
    List<Map<String, dynamic>> albumsData = List.empty(growable: true);
    String query =
        "http://ac.mp3.zing.vn/complete?type=album&num=$quantity&query=$albumName";
    final response = await http.get(Uri.parse(query));
    final Map<String, dynamic> responseInJson = json.decode(response.body);
    int responseLength = 0;
    while (responseLength >= 0) {
      try {
        responseInJson['data'][0]['album'][responseLength]['id'];
        responseLength++;
      } catch (e) {
        break;
      }
    }
    for (var i = 0; i < responseLength; i++) {
      String albumKey = responseInJson['data'][0]['album'][i]['id'];
      Map<String, dynamic> albumData = await getAlbumDataByKey(albumKey);
      albumsData.add(albumData);
    }
    return albumsData;
  }

  ///Get ZingMP3 video data by [videoKey]. [videoKey] is required otherwise it can't be get.
  ///
  ///For example https://zingmp3.vn/video-clip/Kill-This-Love-BLACKPINK/ZWACDBZ6.html then 'ZWACDBZ6' is [videoKey]
  ///
  ///Please note that this can't get VIP video in ZingMP3
  static Future<Map<String, dynamic>> getVideoDataByKey(String videoKey) async {
    Map<String, dynamic> musicData = await _getVideoDataFromZingMp3(videoKey);
    String videoUrl = "";
    String lyricUrl = "";
    String videoName = "";
    String artistName = "";
    String thumbnailUrl = "";
    String videoId = "";
    String artistLink = "";

    videoId = musicData['data']['id'];
    videoName = musicData['data']['name'];
    lyricUrl = musicData['data']['lyric'];
    thumbnailUrl = musicData['data']['thumbnail'];
    artistName = musicData['data']['artist']['name'];
    artistLink = "https://mp3.zing.vn" + musicData['data']['artist']['link'];
    try {
      videoUrl = musicData['data']['source']['mp4']['480p'] ?? "";
    } catch (e) {
      videoUrl = "";
    }

    return {
      'id': videoId,
      'name': videoName,
      'videoUrl': videoUrl,
      'lyricUrl': lyricUrl,
      'artistName': artistName,
      'artistLink': artistLink,
      'thumbnailUrl': thumbnailUrl
    };
  }

  /// Get all video data by name.
  /// Return the first 5 video that match the name by default.
  ///
  /// [videoName] represent for the name of the video you want to find
  /// [quantity] represent for the number of video you want to find. Its default value is 5
  ///
  /// Please note that the return List's length might be < [quantity] depends on the returned JSon Array
  ///
  /// Video audio which require VIP to access won't be able to get.
  /// Because of that, videoUrl of the song which require VIP to access will have value of ' '
  static Future<List<Map<String, dynamic>>> getListVideoDataByName(
      String videoName,
      [int quantity = 5]) async {
    List<Map<String, dynamic>> videosData = List.empty(growable: true);
    String query =
        "http://ac.mp3.zing.vn/complete?type=video&num=$quantity&query=$videoName";
    final response = await http.get(Uri.parse(query));
    final Map<String, dynamic> responseInJson = json.decode(response.body);

    int responseLength = 0;
    while (responseLength >= 0) {
      try {
        responseInJson['data'][0]['video'][responseLength]['id'];
        responseLength++;
      } catch (e) {
        break;
      }
    }

    for (var i = 0; i < responseLength; i++) {
      String videoKey = responseInJson['data'][0]['video'][i]['id'];
      Map<String, dynamic> songData = await getVideoDataByKey(videoKey);
      videosData.add(songData);
    }
    return videosData;
  }

  ///Return artist summary from JSon
  ///
  ///Example response
  ///```dart
  ///'id': 'IWZ9ZOA8',
  ///'name': 'Taylor Swift',
  ///'alias': 'Taylor-Swift'
  ///'thumbnailUrl': 'https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/avatars/5/1/b/8/51b83f6216d3752b5251159c930dcb8d.jpg'
  ///```
  static Map<String, dynamic> _getArtistFromJson(
      Map<String, dynamic> artistDataInJson) {
    String imageUrl = artistDataInJson['thumb'] ?? "";
    String name = artistDataInJson['name'];
    String alias = artistDataInJson['aliasName'];
    String id = artistDataInJson['id'];
    String thumbnailUrl =
        "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/$imageUrl";
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'thumbnailUrl': thumbnailUrl
    };
  }

  ///Get all artist basic data: Id, name, alias, thumbnailUrl
  ///
  ///We can get more data such as biography, all songKey, allAlbum key using LastFmAPI
  ///
  ///This method is use in searching for artist, when we only need to show their avatar and name.
  ///
  ///See this image for easy to understand https://imgur.com/phqmDrN
  ///
  /// [artistName] represent for the name of the name of the artist you want to find
  /// [quantity] represent for the number of artist you want to find. Its default value is 5
  ///
  /// Please note that the returned List's length might be < [quantity] depends on the returned JSon Array
  static Future<List<Map<String, dynamic>>> getAllArtistSummaryDataByName(
      String artistName,
      [int quantity = 5]) async {
    List<Map<String, dynamic>> artistsData = List.empty(growable: true);
    String query =
        "http://ac.mp3.zing.vn/complete?type=artist&num=$quantity&query=$artistName";
    final response = await http.get(Uri.parse(query));
    final Map<String, dynamic> responseInJson = json.decode(response.body);
    int responseLength = 0;
    while (responseLength >= 0) {
      try {
        responseInJson['data'][0]['artist'][responseLength]['id'];
        responseLength++;
      } catch (e) {
        break;
      }
    }
    for (var i = 0; i < responseLength; i++) {
      final artistData =
          _getArtistFromJson(responseInJson['data'][0]['artist'][i]);
      artistsData.add(artistData);
    }
    return artistsData;
  }

  ///This method is use in searching for all data include song, album, video and artist
  ///
  /// [name] represent for the keyword you want to find
  /// [quantity] represent for the number of data you want to find. Its default value is 15
  ///
  /// Please note that the returned List's length might be < [quantity] depends on the returned JSon Array
  static Future<Map<String, dynamic>> getAllDataByName(String name,
      [int quantity = 20]) async {
    int quantityForEach = (quantity / 4).round();
    List<Map<String, dynamic>> songsData =
        await getListSongDataByName(name, quantityForEach);
    List<Map<String, dynamic>> videosData =
        await getListVideoDataByName(name, quantityForEach);
    List<Map<String, dynamic>> albumsData =
        await getListAlbumDataByName(name, quantityForEach);
    List<Map<String, dynamic>> artistData =
        await getAllArtistSummaryDataByName(name, quantityForEach);
    return {
      'songs': songsData,
      'videos': videosData,
      'albums': albumsData,
      'artists': artistData
    };
  }

  ///Get all current top VPOP song key base on https://zingmp3.vn/zing-chart-tuan/bai-hat-Viet-Nam/IWZ9Z08I.html
  static Future<List<String>> getAllTopVPOPSongKey() async {
    List<String> songs = List.empty(growable: true);
    String query =
        "https://mp3.zing.vn/xhr/chart-realtime?songId=0&videoId=0&albumId=0&chart=song&time=-1";
    final response = await http.get(Uri.parse(query));
    Map<String, dynamic> responseInJson = json.decode(response.body);
    int songCount = 0;
    while (songCount >= 0) {
      try {
        responseInJson['data']['song'][songCount];
        songCount++;
      } catch (e) {
        break;
      }
    }
    for (var i = 0; i < songCount; i++) {
      final song = responseInJson['data']['song'][i]['id'];

      songs.add(song);
    }
    return songs;
  }

  ///Get all current top USUK song key base on https://zingmp3.vn/zing-chart-tuan/bai-hat-US-UK/IWZ9Z0BW.html
  static Future<List<String>> getAllTopUSUKSongKey() async {
    const slashCharacterInAscii = 47;
    const dotCharacterInAscii = 46;
    dom.Document html = await _getWebsiteHtmlCode(
        "https://m.zingmp3.vn/zing-chart-tuan/bai-hat-Au-My/IWZ9Z0BW.html");
    String albumUrl = html
            .getElementsByClassName(
                "z-btn z-btn-radius btn-play-album btn-open-app")[0]
            .attributes['href'] ??
        "";
    int lastSlashCharacter = 0;
    int lastDotCharacter = 0;
    for (var i = 0; i < albumUrl.length; i++) {
      if (albumUrl.codeUnitAt(i) == slashCharacterInAscii) {
        lastSlashCharacter = i;
      }
      if (albumUrl.codeUnitAt(i) == dotCharacterInAscii) {
        lastDotCharacter = i;
      }
    }
    String albumKey =
        albumUrl.substring(lastSlashCharacter + 1, lastDotCharacter);
    final albumData = await getAlbumDataByKey(albumKey);
    return albumData['songs'];
  }

  ///Get all current top KPOP song key base on https://zingmp3.vn/zing-chart-tuan/bai-hat-Kpop/IWZ9Z0BO.html
  static Future<List<String>> getAllTopKpopSongKey() async {
    const slashCharacterInAscii = 47;
    const dotCharacterInAscii = 46;
    dom.Document html = await _getWebsiteHtmlCode(
        "https://m.zingmp3.vn/zing-chart-tuan/Bai-hat-KPop/IWZ9Z0BO.html");
    String albumUrl = html
            .getElementsByClassName(
                "z-btn z-btn-radius btn-play-album btn-open-app")[0]
            .attributes['href'] ??
        "";
    int lastSlashCharacter = 0;
    int lastDotCharacter = 0;
    for (var i = 0; i < albumUrl.length; i++) {
      if (albumUrl.codeUnitAt(i) == slashCharacterInAscii) {
        lastSlashCharacter = i;
      }
      if (albumUrl.codeUnitAt(i) == dotCharacterInAscii) {
        lastDotCharacter = i;
      }
    }
    String albumKey =
        albumUrl.substring(lastSlashCharacter + 1, lastDotCharacter);
    final albumData = await getAlbumDataByKey(albumKey);
    return albumData['songs'];
  }
}

import 'dart:math';

import 'package:just_audio/just_audio.dart';

import '../entities/entities.dart';

class PlayNextPreHandler {
  List<SongInfo> listSongInfo;
  List<SongInfo> playedSongs = List.empty(growable: true);
  final _random = Random();
  late SongInfo currentSongInfo;
  PlayNextPreHandler(this.listSongInfo);
  bool isPlayShuffle = false;

  void setListSongInfo(List<SongInfo> listSongInfo) {
    this.listSongInfo = listSongInfo;
  }

  SongInfo getRandomSong() {
    int index = _random.nextInt(listSongInfo.length);
    SongInfo randomSong = listSongInfo.elementAt(index);
    if (playedSongs.contains(randomSong)) {
      return getRandomSong();
    }
    return randomSong;
  }

  SongInfo? getNextSong(bool playShuffle, LoopMode loopMode) {
    int currentIndex = listSongInfo.indexOf(currentSongInfo);
    late SongInfo nextSong;

    if (currentIndex + 1 >= listSongInfo.length ||
        playedSongs.length == listSongInfo.length) {
      switch (loopMode) {
        case LoopMode.all:
          resetPlayedSong();
          nextSong = playShuffle ? getRandomSong() : listSongInfo.elementAt(0);
          break;
        default:
          return null;
      }
    } else {
      nextSong = playShuffle
          ? getRandomSong()
          : listSongInfo.elementAt(currentIndex + 1);
    }

    currentSongInfo = nextSong;
    playedSongs.add(nextSong);

    playedSongs = playedSongs.toSet().toList();
    return nextSong;
  }

  SongInfo getPreviousSong() {
    List<String> playedTitle = List.empty(growable: true);
    for (var song in playedSongs) {
      playedTitle.add(song.title!);
    }
    playedSongs.removeLast();
    currentSongInfo = playedSongs.last;
    return playedSongs.last;
  }

  void resetPlayedSong() {
    playedSongs = List.empty(growable: true);
  }

  bool isPlayedAllPlaylist() {
    return playedSongs.toSet().toList().length == listSongInfo.length;
  }
}

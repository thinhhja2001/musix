import 'dart:math';

import 'package:musix/domain_song/entities/entities.dart';

class PlayNextPreHandler {
  List<SongInfo> listSongInfo;
  List<SongInfo> playedSong = List.empty(growable: true);
  final _random = Random();
  int currentIndex = 0;
  PlayNextPreHandler(this.listSongInfo);
  bool isPlayShuffle = false;

  void setListSongInfo(List<SongInfo> listSongInfo) {
    this.listSongInfo = listSongInfo;
  }

  // setBaseIndex will be called if user click the song on the playlist screen.
  void setBaseIndex(int index) {
    playedSong = List.empty(growable: true);
    currentIndex = index;
    playedSong.add(listSongInfo.elementAt(currentIndex));
  }

  int getNextIndexOfRandomSong() {
    int index = _random.nextInt(listSongInfo.length);
    SongInfo randomSong = listSongInfo.elementAt(index);
    if (playedSong.contains(randomSong)) {
      return getNextIndexOfRandomSong();
    }
    return index;
  }

  SongInfo getNextSong(bool playShuffle) {
    if (!playShuffle) {
      currentIndex++;
    } else {
      currentIndex = getNextIndexOfRandomSong();
    }

    playedSong.add(listSongInfo.elementAt(currentIndex));
    return listSongInfo.elementAt(currentIndex);
  }

  SongInfo getPreviousSong() {
    playedSong.removeLast();

    return playedSong.last;
  }

  void resetPlayedSong() {
    playedSong = List.empty(growable: true);
  }

  bool isPlayedAllPlaylist() {
    return playedSong.toSet().toList().length == listSongInfo.length;
  }
}

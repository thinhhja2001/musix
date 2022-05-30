import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musix/models/song.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/enums.dart';
import 'package:musix/utils/utils.dart';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class AudioPlayerProvider extends ChangeNotifier {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  LoopType loopType = LoopType.noLoop;
  Song currentSong = songWithNoData;
  Album currentAlbum = albumWithNoData;
  bool isPlayShuffle = false;
  List<int> _playedIndexOfAlbum = List.empty(growable: true);
  int _currentIndex = 0;
  String lyric = "";
  AudioPlayerProvider() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.PLAYING;
      notifyListeners();
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });
  }

  void updateCurrentAlbum(Album newAlbum) {
    currentAlbum = newAlbum;
    notifyListeners();
  }

  void changeLoopStyle(BuildContext context) {
    switch (loopType) {
      case LoopType.noLoop:
        loopType = LoopType.loopList;
        break;
      case LoopType.loopList:
        loopType = LoopType.loop1;
        break;
      case LoopType.loop1:
        loopType = LoopType.noLoop;
        break;
      default:
    }
    _playAudioAccordingToLoopStyle(context);
    notifyListeners();
  }

  void changePlayState() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void updateSongUrl(String newSongUrl) {
    currentSong.audioUrl = newSongUrl;
    notifyListeners();
  }

  void seekToNewPosition(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  void pauseSong() async {
    await audioPlayer.pause();
    notifyListeners();
  }

  void setCurrentAlbum(Album newAlbum) {
    currentAlbum = newAlbum;
    notifyListeners();
  }

  void toggleIsPlayShuffle() {
    isPlayShuffle = !isPlayShuffle;
    notifyListeners();
  }

  void playSong(Song song, BuildContext context) async {
    currentSong = song;
    if (currentSong.audioUrl.isNotEmpty) {
      _getLyricFromLrcLink(currentSong.lyricUrl);
      await audioPlayer.play(currentSong.audioUrl);
    } else {
      showSnackBar('This song is not available right now', context, Colors.red);
    }
    notifyListeners();
  }

  void playAlbum(
      {required Album album, required BuildContext context, int? index}) async {
    setCurrentAlbum(album);
    _playedIndexOfAlbum = List.empty(growable: true);
    if (isPlayShuffle) {
      _currentIndex = _generateRandomIndex();
    }
    if (index != null) {
      _currentIndex = index;
    }
    Song song =
        await SongMethods.getSongDataByKey(currentAlbum.songs[_currentIndex]);
    playSong(song, context);
    _playedIndexOfAlbum.add(_currentIndex);
    notifyListeners();
  }

  void playForward(BuildContext context) async {
    if (currentAlbum != albumWithNoData) {
      _playNextSongInCurrentAlbum(context);
    } else {
      seekToNewPosition(Duration(seconds: duration.inSeconds - 5));
    }
  }

  void playBackward(BuildContext context) async {
    if (_playedIndexOfAlbum.length > 1) {
      _playPreviousSongInCurrentAlbum(context);
    } else {
      seekToNewPosition(Duration.zero);
    }
    notifyListeners();
  }

  void removeCurrentAlbum() {
    _playedIndexOfAlbum = List.empty(growable: true);
    currentAlbum = albumWithNoData;
    notifyListeners();
  }

  void _playAudioAccordingToLoopStyle(BuildContext context) {
    switch (loopType) {
      case LoopType.noLoop:
        if (currentAlbum == albumWithNoData ||
            _playedIndexOfAlbum.length == currentAlbum.songs.length) {
          audioPlayer.onPlayerCompletion.listen((event) {
            position = duration;
            isPlaying = false;
            audioPlayer.stop();
          });
        } else {
          playForward(context);
        }

        break;
      case LoopType.loop1:
        _loopCurrentSong();
        break;
      case LoopType.loopList:
        if (currentAlbum == albumWithNoData) {
          _loopCurrentSong();
        }
        if (_playedIndexOfAlbum.length == currentAlbum.songs.length) {
          playAlbum(album: currentAlbum, context: context);
        }
        break;
      default:
    }
    notifyListeners();
  }

  void _getLyricFromLrcLink(String lrcLink) async {
    try {
      final response = await http.get(Uri.parse(lrcLink));
      lyric = utf8.decode(response.bodyBytes);
    } catch (e) {
      lyric = "";
    }
    notifyListeners();
  }

  void _playPreviousSongInCurrentAlbum(BuildContext context) async {
    _playedIndexOfAlbum.removeLast();
    _currentIndex = _playedIndexOfAlbum[_playedIndexOfAlbum.length - 1];
    Song song =
        await SongMethods.getSongDataByKey(currentAlbum.songs[_currentIndex]);
    playSong(song, context);
  }

  void _playNextSongInCurrentAlbum(BuildContext context) async {
    if (isPlayShuffle) {
      _currentIndex = _generateRandomIndex();
    } else {
      _currentIndex++;
    }
    Song song =
        await SongMethods.getSongDataByKey(currentAlbum.songs[_currentIndex]);
    if (song.audioUrl.isEmpty) {
      showSnackBar('This song is not available right now', context, Colors.red);
      _playNextSongInCurrentAlbum(context);
    }
    playSong(song, context);
    _playedIndexOfAlbum.add(_currentIndex);
    notifyListeners();
  }

  void _loopCurrentSong() {
    audioPlayer.onPlayerCompletion.listen((event) {
      position = Duration.zero;
      isPlaying = true;
      audioPlayer.play(currentSong.audioUrl);
    });
  }

  int _generateRandomIndex() {
    Random random = Random();

    int randomIndex = random.nextInt(currentAlbum.songs.length);
    if (_playedIndexOfAlbum.contains(randomIndex)) {
      return _generateRandomIndex();
    }
    return randomIndex;
  }
}

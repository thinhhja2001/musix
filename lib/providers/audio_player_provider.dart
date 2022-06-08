import 'dart:convert';
import 'dart:math';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musix/models/song.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/enums.dart';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class AudioPlayerProvider with ChangeNotifier {
  final audioPlayer = AudioPlayer();
  LoopType loopType = LoopType.noLoop;
  Song currentSong = songWithNoData;
  Album currentAlbum = albumWithNoData;
  bool isPlayShuffle = false;
  List<int> _playedIndexOfAlbum = List.empty(growable: true);
  int _currentIndex = 0;
  String lyric = "";
  AudioPlayerProvider() {
    audioPlayer.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        await _playAudioAccordingToLoopStyle();
      }
    });
    notifyListeners();
  }

  void updateCurrentAlbum(Album newAlbum) {
    currentAlbum = newAlbum;
    notifyListeners();
  }

  Future<void> changeLoopStyle() async {
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
    audioPlayer.playerStateStream.listen((event) async {
      if (event.processingState == ProcessingState.completed) {
        await _playAudioAccordingToLoopStyle();
      }
    });
    notifyListeners();
  }

  void updateSongUrl(String newSongUrl) {
    currentSong.audioUrl = newSongUrl;
    notifyListeners();
  }

  Future<void> seekToNewPosition(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  Future<void> pauseSong() async {
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

  Future<void> playSong(Song song) async {
    currentSong = song;
    _getLyricFromLrcLink(currentSong.lyricUrl);
    await audioPlayer.setUrl(currentSong.audioUrl);
    await audioPlayer.play();
    await SongMethods.addSongToListenHistory(currentSong);

    notifyListeners();
  }

  Future<void> resume() async {
    await audioPlayer.play();
    notifyListeners();
  }

  Future<void> playAlbum({required Album album, int? index}) async {
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
    await playSong(song);
    _playedIndexOfAlbum.add(_currentIndex);
    if (currentAlbum.id != unfavorable) {
      await PlaylistMethods.addAlbumToListenHistory(currentAlbum);
    }
    notifyListeners();
  }

  Future<void> playForward() async {
    if (currentAlbum != albumWithNoData) {
      await _playNextSongInCurrentAlbum();
    } else {
      await seekToNewPosition(
          Duration(seconds: audioPlayer.duration!.inSeconds - 5));
    }
  }

  Future<void> playBackward() async {
    if (_playedIndexOfAlbum.length > 1) {
      await _playPreviousSongInCurrentAlbum();
    } else {
      await seekToNewPosition(Duration.zero);
    }
    notifyListeners();
  }

  void removeCurrentAlbum() {
    _playedIndexOfAlbum = List.empty(growable: true);
    currentAlbum = albumWithNoData;
    notifyListeners();
  }

  Future<void> _playAudioAccordingToLoopStyle() async {
    audioPlayer.seek(Duration.zero);
    notifyListeners();
    switch (loopType) {
      case LoopType.noLoop:
        if (currentAlbum == albumWithNoData ||
            _playedIndexOfAlbum.length == currentAlbum.songs.length) {
          await pauseSong();
        } else if (_playedIndexOfAlbum.length < currentAlbum.songs.length) {
          await playForward();
        } else {
          await pauseSong();
        }
        break;
      case LoopType.loop1:
        await playSong(currentSong);

        break;
      case LoopType.loopList:
        if (currentAlbum == albumWithNoData) {
          await playSong(currentSong);
        } else if (_playedIndexOfAlbum.length == currentAlbum.songs.length) {
          await playAlbum(album: currentAlbum);
        } else if (_playedIndexOfAlbum.length < currentAlbum.songs.length) {
          await playForward();
        } else {
          await pauseSong();
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

  Future<void> _playPreviousSongInCurrentAlbum() async {
    _playedIndexOfAlbum.removeLast();
    _currentIndex = _playedIndexOfAlbum[_playedIndexOfAlbum.length - 1];
    Song song =
        await SongMethods.getSongDataByKey(currentAlbum.songs[_currentIndex]);
    await playSong(song);
  }

  Future<void> _playNextSongInCurrentAlbum() async {
    if (isPlayShuffle) {
      _currentIndex = _generateRandomIndex();
    } else {
      _currentIndex++;
    }
    Song song =
        await SongMethods.getSongDataByKey(currentAlbum.songs[_currentIndex]);
    if (song.audioUrl.isEmpty) {
      await _playNextSongInCurrentAlbum();
    }
    await playSong(song);
    _playedIndexOfAlbum.add(_currentIndex);
    notifyListeners();
  }

  void _loopCurrentSong() {
    // audioPlayer.onPlayerCompletion.listen((event) {
    //   position = Duration.zero;
    //   isPlaying = true;
    //   audioPlayer.play(currentSong.audioUrl);
    // });
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

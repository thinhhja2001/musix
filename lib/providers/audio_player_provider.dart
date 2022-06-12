import 'dart:convert';
import 'dart:math';
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:musix/models/album.dart';
import 'package:musix/models/song.dart';
import 'package:musix/resources/playlist_methods.dart';
import 'package:musix/resources/song_methods.dart';
import 'package:musix/utils/constant.dart';
import 'package:musix/utils/enums.dart';
import 'package:http/http.dart' as http;

class AudioPlayerProvider extends ChangeNotifier {
  LoopType loopType = LoopType.noLoop;
  Song currentSong = songWithNoData;
  Album currentAlbum = albumWithNoData;
  bool isPlaying = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlayShuffle = false;
  List<int> _playedIndexOfAlbum = List.empty(growable: true);
  int _currentIndex = 0;
  String lyric = "";

  void setAudioManagerEvent() {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.timeupdate:
          duration = AudioManager.instance.duration;
          position = AudioManager.instance.position;
          notifyListeners();
          break;
        case AudioManagerEvents.ready:
          duration = AudioManager.instance.duration;
          position = AudioManager.instance.position;
          notifyListeners();

          break;
        case AudioManagerEvents.start:
          duration = AudioManager.instance.duration;
          position = AudioManager.instance.position;
          notifyListeners();

          break;
        case AudioManagerEvents.playstatus:
          isPlaying = AudioManager.instance.isPlaying;
          notifyListeners();
          break;
        case AudioManagerEvents.ended:
          _playAudioAccordingToLoopStyle();
          notifyListeners();
          break;
        case AudioManagerEvents.next:
          playForward();
          notifyListeners();
          break;
        default:
      }
    });
    notifyListeners();
  }

  AudioPlayerProvider() {
    setAudioManagerEvent();
  }
  changeIsPlayingState() {
    isPlaying = !isPlaying;
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
        notifyListeners();

        break;
      case LoopType.loopList:
        loopType = LoopType.loop1;
        notifyListeners();

        break;
      case LoopType.loop1:
        loopType = LoopType.noLoop;
        notifyListeners();

        break;
      default:
    }
    setAudioManagerEvent();

    notifyListeners();
  }

  void updateSongUrl(String newSongUrl) {
    currentSong.audioUrl = newSongUrl;
    notifyListeners();
  }

  Future<void> seekToNewPosition(Duration position) async {
    AudioManager.instance.seekTo(position);
    notifyListeners();
  }

  Future<void> pauseSong() async {
    AudioManager.instance.toPause();
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
    AudioManager.instance.start(song.audioUrl, song.name,
        desc: song.artistName, cover: song.thumbnailUrl);
    await SongMethods.addSongToListenHistory(currentSong);

    notifyListeners();
  }

  Future<void> resume() async {
    AudioManager.instance.toPlay();
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
      await seekToNewPosition(Duration(seconds: duration.inSeconds - 5));
    }
    notifyListeners();
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
    await seekToNewPosition(Duration.zero);
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
        } else if (_playedIndexOfAlbum.length < currentAlbum.songs.length) {
          await playForward();
        } else if (_playedIndexOfAlbum.length == currentAlbum.songs.length) {
          await playAlbum(album: currentAlbum, index: 0);
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
    if (song.audioUrl.isEmpty) {
      _playPreviousSongInCurrentAlbum();
    }
    await playSong(song);
    notifyListeners();
  }

  Future<void> _playNextSongInCurrentAlbum() async {
    if (isPlayShuffle) {
      ///If all songs in current album has been played,
      ///then auto play current album at index of 0,
      ///else, play at random index which has never been played
      ///The code below was made to avoid Stack overflow
      if (_playedIndexOfAlbum.length < currentAlbum.songs.length) {
        _currentIndex = _generateRandomIndex();
      } else {
        if (loopType == LoopType.loopList) {
          playAlbum(album: currentAlbum, index: 1);
          return;
        }
      }
    } else {
      _currentIndex++;
    }
    if (_playedIndexOfAlbum.length == currentAlbum.songs.length ||
        _currentIndex >= currentAlbum.songs.length) {
      if (loopType == LoopType.loopList) {
        playAlbum(album: currentAlbum, index: 0);
        notifyListeners();
      }
    } else {
      try {
        Song song = await SongMethods.getSongDataByKey(
            currentAlbum.songs[_currentIndex]);
        await playSong(song);
        if (song.audioUrl.isEmpty) {
          _playNextSongInCurrentAlbum();
        }
      } catch (e) {
        _playNextSongInCurrentAlbum();
      }

      _playedIndexOfAlbum.add(_currentIndex);
    }

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

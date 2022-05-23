import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:musix/models/song.dart';
import 'package:musix/utils/enums.dart';

class AudioPlayerProvider extends ChangeNotifier {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  LoopType loopType = LoopType.noLoop;
  Song currentSong = Song(
      id: '',
      name: '',
      audioUrl: '',
      lyricUrl: '',
      artistName: '',
      artistLink: '',
      thumbnailUrl:
          'https://2.bp.blogspot.com/-muVbmju-gkA/Vir94NirTeI/AAAAAAAAT9c/VoHzHZzQmR4/s1600/placeholder-image.jpg');

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
  void _playAudioAccordingToLoopStyle() {
    switch (loopType) {
      case LoopType.noLoop:
        audioPlayer.onPlayerCompletion.listen((event) {
          position = duration;
          isPlaying = false;
          audioPlayer.stop();
        });
        break;
      case LoopType.loop1:
        audioPlayer.onPlayerCompletion.listen((event) {
          position = Duration.zero;
          isPlaying = true;
          audioPlayer.play(currentSong.audioUrl);
        });
        break;
      default:
    }
    notifyListeners();
  }

  void changeLoopStyle() {
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
    _playAudioAccordingToLoopStyle();
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

  void playSong(Song song) async {
    currentSong = song;
    await audioPlayer.play(currentSong.audioUrl);
    notifyListeners();
  }
}

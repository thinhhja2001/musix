import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayerProvider extends ChangeNotifier {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  String songUrl =
      "https://vnso-zn-15-tf-mp3-s1-m-zmp3.zmdcdn.me/ad72e5d09d9474ca2d85/4240633508708308556?authen=exp=1651324614~acl=/ad72e5d09d9474ca2d85/*~hmac=74f0e90ff13eeef96b5a327cd6b1c197&fs=MTY1MTE1MTgxNDM4M3x3ZWJWNHw0Mi4xMTYdUngMTE1Ljg3";
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
  void changePlayState() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void updateSongUrl(String newSongUrl) {
    songUrl = newSongUrl;
    notifyListeners();
  }

  void seekToNewPosition(Duration position) async {
    await audioPlayer.seek(position);
    notifyListeners();
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    notifyListeners();
  }

  void playAudio() async {
    await audioPlayer.play(songUrl);
    notifyListeners();
  }
}

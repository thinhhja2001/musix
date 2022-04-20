import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayerProvider extends ChangeNotifier {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  String songUrl =
      "https://vnso-zn-23-tf-mp3-s1-m-zmp3.zmdcdn.me/7a409650d911304f6900/7704349691708005710?authen=exp=1650546921~acl=/7a409650d911304f6900/*~hmac=51185422deca26c4357d613ab3a1adae&fs=MTY1MDM3NDEyMTg2OHx3ZWJWNHwxMjUdUngMjM1LjIxNC4yMjmUsIC";
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

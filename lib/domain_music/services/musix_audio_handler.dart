import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../utils/functions/function_utils.dart';
import '../models/models.dart';

class MusixAudioHandler extends BaseAudioHandler with SeekHandler {
  final player = AudioPlayer();
  //Singleton to display currentSong
  Song currentSong = sampleSong;
  String lyric = "";

  /// Initialize our audio handler.
  MusixAudioHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    // ... and also the current media item via mediaItem.
  }

  void setSong(Song song) async {
    //Get the song duration since _player.seAudioSource will get the duration as NULL
    final duration = await player.setUrl(song.audioUrl);

    currentSong = song;
    lyric = await getLyric(currentSong.lyricUrl);
    //To add the song to the background service, you must do the code below
    final item = MediaItem(
      id: song.audioUrl,
      title: song.name,
      duration: duration,
      artist: song.artistName,
      artUri: Uri.parse(song.thumbnailUrl),
    );

    mediaItem.add(item);
    player.setAudioSource(AudioSource.uri(Uri.parse(item.id)));
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) async {
    print('seeking to new position: $position');
    player.seek(position);
  }

  @override
  Future<void> stop() => player.stop();

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[player.processingState]!,
      playing: player.playing,
      updatePosition: player.position,
      bufferedPosition: player.bufferedPosition,
      speed: player.speed,
      queueIndex: event.currentIndex,
    );
  }
}

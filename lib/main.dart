import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musix/config/app.dart';

import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  final audioPlayer = AudioPlayer();
  GetIt.I.registerSingleton<AudioPlayer>(audioPlayer);
  boostrap();
}

void boostrap() {
  final debugLogger = DebugLogger();
  FlutterError.onError = (details) {
    debugLogger.log(details.exceptionAsString(), details.stack);
  };

  Bloc.observer = AppObserver();

  runZonedGuarded(
    () => runApp(
      const MusixApp(),
    ),
    (error, stackTrace) {
      debugLogger.log(error.toString());
    },
  );
}

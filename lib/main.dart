import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:musix/config/app.dart';
import 'package:musix/domain_music/services/musix_audio_hander.dart';

import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap();
}

void bootstrap() {
  final debugLogger = DebugLogger();
  FlutterError.onError = (details) {
    debugLogger.log(details.exceptionAsString(), details.stack);
  };

  Bloc.observer = AppObserver();
  configAudioService();
  runZonedGuarded(
    () => runApp(
      const MusixApp(),
    ),
    (error, stackTrace) {
      debugLogger.log(error.toString());
    },
  );
}

void configAudioService() async {
  final audioHandler = await AudioService.init(
    builder: () => MusixAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
  GetIt.I.registerSingleton<MusixAudioHandler>(audioHandler);
}

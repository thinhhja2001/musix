import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'config/app.dart';

import 'domain_music/services/musix_audio_handler.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
}

Future<void> bootstrap() async {
  final debugLogger = DebugLogger();
  FlutterError.onError = (details) {
    debugLogger.log(details.exceptionAsString(), details.stack);
  };

  Bloc.observer = AppObserver();
  //Need to use await here to avoid facing the GetIt plugin error like https://stackoverflow.com/questions/61131822/flutter-getit-plugin-no-type-xxx-is-registered-inside-getit
  await configAudioService();
  runZonedGuarded(
    () => runApp(
      const MusixApp(),
    ),
    (error, stackTrace) {
      debugLogger.log(error.toString());
    },
  );
}

Future<void> configAudioService() async {
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

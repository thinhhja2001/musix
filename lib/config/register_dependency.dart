import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import 'exporter.dart';

final getIt = GetIt.instance;

FutureOr<void> registerDependency() async {
  getIt.registerFactoryAsync<ZingMP3APIV2>(() => ZingMP3APIV2.createAsync());
  getIt.registerLazySingleton<PlaylistRepo>(() => PlaylistRepo());
  getIt.registerLazySingleton<HubRepo>(() => HubRepo());
  getIt.registerLazySingleton<ArtistRepo>(() => ArtistRepo());
}

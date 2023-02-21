import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:musix/domain_album/repo/playlist_repo.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

final getIt = GetIt.instance;

FutureOr<void> registerDependency() async {
  getIt.registerFactoryAsync<ZingMP3APIV2>(() => ZingMP3APIV2.createAsync());
  getIt.registerLazySingleton<PlaylistRepo>(() => PlaylistRepo());
}

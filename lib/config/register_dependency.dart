import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zing_mp3_api/zing_mp3_api.dart';

import 'exporter/repo_exporter.dart';

final getIt = GetIt.instance;

FutureOr<void> registerDependency() async {
  getIt.registerFactoryAsync<ZingMP3APIV2>(() => ZingMP3APIV2.createAsync());
  getIt.registerLazySingleton<TextEditingController>(
      () => TextEditingController());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo());
  getIt.registerLazySingleton<PlaylistRepo>(() => PlaylistRepo());
  getIt.registerLazySingleton<HubRepo>(() => HubRepo());
  getIt.registerLazySingleton<ArtistRepo>(() => ArtistRepo());
  getIt.registerLazySingleton<SongInfoRepositoryImpl>(
      () => SongInfoRepositoryImpl());
  getIt.registerLazySingleton<SongSourceRepositoryImpl>(
      () => SongSourceRepositoryImpl());

  getIt.registerLazySingleton<VideoRepositoryImpl>(() => VideoRepositoryImpl());
  getIt.registerLazySingleton<HomeMusicRepo>(() => HomeMusicRepo());
  getIt.registerLazySingleton<SearchMusicRepo>(() => SearchMusicRepo());
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo());
  getIt.registerLazySingleton<UserMusicRepo>(() => UserMusicRepo());
  getIt.registerLazySingleton<CommentRepo>(() => CommentRepo());
  getIt.registerLazySingleton<PostRepo>(() => PostRepo());
  getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
}

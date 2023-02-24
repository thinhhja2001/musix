import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/app_view.dart';
import 'package:musix/domain_music/services/musix_audio_handler.dart';

import '../domain_global/entities/home_music/event/home_music_event.dart';
import '../utils/utils.dart';
import 'exporter.dart';
import 'register_dependency.dart';

class MusixApp extends StatefulWidget {
  const MusixApp({super.key});

  @override
  State<MusixApp> createState() => _MusixAppState();
}

class _MusixAppState extends State<MusixApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => HomeMusicBloc(
            initialState: HomeMusicState(
              status: {
                HomeMusicStatusKey.global.key: Status.idle,
              },
            ),
            homeMusicRepo: getIt.get<HomeMusicRepo>(),
          )..add(const HomeMusicGetEvent()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => PlaylistBloc(
              initialState: PlaylistState(
                status: {
                  PlaylistStatusKey.global.key: Status.idle,
                },
              ),
              playlistRepo: getIt.get<PlaylistRepo>(),
              hubRepo: getIt.get<HubRepo>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => ArtistBloc(
            initialState: ArtistState(
              status: {
                ArtistStatusKey.global.key: Status.idle,
              },
            ),
            artistRepo: getIt.get<ArtistRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => SongBloc(
            musixAudioHandler: getIt.get<MusixAudioHandler>(),
            initialState: SongState(
              status: {
                SongStatusKey.global.key: Status.idle,
              },
            ),
            songInfoRepositoryImpl: getIt.get<SongInfoRepositoryImpl>(),
            songSourceRepositoryImpl: getIt.get<SongSourceRepositoryImpl>(),
          ),
        ),
      ],
      child: const MusixAppView(),
    );
  }
}

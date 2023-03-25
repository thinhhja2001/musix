import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/domain_auth/entities/state/auth_state.dart';
import 'package:musix/domain_auth/repo/auth_repo.dart';

import '../domain_song/services/musix_audio_handler.dart';
import '../utils/utils.dart';
import 'app_view.dart';
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
          create: (context) => AuthBloc(
            initialState: AuthState(),
            authRepo: getIt.get<AuthRepo>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => HomeMusicBloc(
            initialState: HomeMusicState(
              status: {
                HomeMusicStatusKey.global.key: Status.idle,
              },
            ),
            homeMusicRepo: getIt.get<HomeMusicRepo>(),
            hubRepo: getIt.get<HubRepo>(),
          )..add(const HomeMusicGetEvent()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SearchMusicBloc(
            initialState: SearchMusicState(
              status: {
                SearchMusicStatusKey.global.key: Status.idle,
              },
            ),
            repo: getIt.get<SearchMusicRepo>(),
          ),
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
          ),
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
          lazy: false,
          create: (context) => HubBloc(
            initialState: HubState(
              status: {
                HubStatusKey.global.key: Status.idle,
              },
            ),
            hubRepo: getIt.get<HubRepo>(),
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
        BlocProvider(
          create: (context) => VideoBloc(
            initialState: VideoState(
              status: {VideoStatusKey.global.key: Status.idle},
            ),
            videoRepositoryImpl: getIt.get<VideoRepositoryImpl>(),
          ),
        )
      ],
      child: const MusixAppView(),
    );
  }
}

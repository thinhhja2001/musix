import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain_video/entities/state/video_key.dart';
import '../domain_video/entities/state/video_state.dart';
import '../domain_video/logic/video_bloc.dart';
import '../domain_artist/entities/entities.dart';
import '../domain_global/entities/home_music/state.dart';
import '../domain_hub/entities/entities.dart';
import '../domain_playlist/entities/entities.dart';
import '../domain_playlist/logic/playlist_bloc.dart';
import 'app_view.dart';
import '../domain_song/entities/entities.dart';
import '../domain_song/logic/song_bloc.dart';
import '../domain_song/services/musix_audio_handler.dart';

import '../utils/utils.dart';
import 'exporter.dart';
import 'exporter/repo_exporter.dart';
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
            hubRepo: getIt.get<HubRepo>(),
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

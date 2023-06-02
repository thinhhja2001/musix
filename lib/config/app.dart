import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:musix/domain_auth/utils/model/auth_storage.dart';

import '../domain_song/services/musix_audio_handler.dart';
import '../routing/routing_path.dart';
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
  AuthStorage? authStorage;
  @override
  void initState() {
    _getAuthStorage();
    super.initState();
  }

  void _getAuthStorage() {
    authStorage = HiveUtils.readAuthStorage();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) {
            return AuthBloc(
              initialState: AuthState(),
              authRepo: getIt.get<AuthRepo>(),
            )..add(AuthAutoLoginEvent(
                authStorage?.token ?? "", authStorage?.username ?? ""));
          },
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
          create: (context) => ProfileBloc(
            initialState: ProfileState(
              status: {
                ProfileStatusKey.global.name: Status.idle,
              },
            ),
            authBloc: context.read<AuthBloc>(),
            profileRepo: getIt.get<ProfileRepo>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => UserMusicBloc(
            initialState: UserMusicState(
              status: {
                UserMusicStatusKey.global.name: Status.idle,
              },
            ),
            authBloc: context.read<AuthBloc>(),
            userMusicRepo: getIt.get<UserMusicRepo>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => OwnPlaylistBloc(
            initialState: OwnPlaylistState(
              status: {
                OwnPlaylistStatusKey.global.name: Status.idle,
              },
            ),
            songRepo: getIt.get<SongInfoRepositoryImpl>(),
          ),
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
          create: (context) => PlaylistsBloc(
            initialState: PlaylistsState(
              status: {
                PlaylistsStatusKey.global.name: Status.idle,
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
          create: (context) => ArtistsBloc(
            initialState: ArtistsState(
              status: {
                ArtistsStatusKey.global.name: Status.idle,
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
          lazy: false,
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
          lazy: false,
          create: (context) => SongsBloc(
            initialState: SongsState(
              status: {
                SongStatusKey.global.key: Status.idle,
              },
            ),
            songRepo: getIt.get<SongInfoRepositoryImpl>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => VideoBloc(
            initialState: VideoState(
              status: {VideoStatusKey.global.key: Status.idle},
            ),
            videoRepositoryImpl: getIt.get<VideoRepositoryImpl>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SocialBloc(
            initialState: const SocialState(),
            commentRepo: getIt.get<CommentRepo>(),
            authBloc: context.read<AuthBloc>(),
            postRepo: getIt.get<PostRepo>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CommentBloc(
            initialState: CommentState(
              status: {
                CommentStatusKey.global.name: Status.idle,
              },
            ),
            authBloc: context.read<AuthBloc>(),
            commentRepo: getIt.get<CommentRepo>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SocialSearchBloc(
            initialState: SocialSearchState(
              status: {
                SocialSearchStatusKey.global.name: Status.idle,
              },
            ),
            profileRepo: getIt.get<ProfileRepo>(),
            postRepo: getIt.get<PostRepo>(),
            authBloc: context.read<AuthBloc>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => UserRecordBloc(
            initialState: UserRecordState(
              status: {
                UserRecordStatusKey.global.name: Status.idle,
              },
            ),
            userMusicRepo: getIt.get<UserMusicRepo>(),
            songRepo: getIt.get<SongInfoRepositoryImpl>(),
            authBloc: context.read<AuthBloc>(),
            recommendRepo: getIt.get<SongRecommendationRepo>(),
          ),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(buildWhen: (prev, curr) {
        return curr.jwtToken != null &&
            curr.jwtToken != "" &&
            prev.jwtToken != curr.jwtToken;
      }, builder: (context, state) {
        if (state.jwtToken != null && state.jwtToken != "") {
          return const MusixAppView(
            path: RoutingPath.home,
          );
        } else {
          return const MusixAppView();
        }
      }),
    );
  }
}

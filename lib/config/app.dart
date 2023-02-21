import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/config/app_view.dart';

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
          create: (context) => PlaylistBloc(
            initialState: PlaylistState(status: {
              PlaylistStatusKey.global.key: Status.idle,
            }),
            playlistRepo: getIt.get<PlaylistRepo>(),
          ),
        ),
      ],
      child: const MusixAppView(),
    );
  }
}

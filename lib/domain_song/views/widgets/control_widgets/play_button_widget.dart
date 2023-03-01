// ignore_for_file: implementation_imports

import 'package:chewie/src/animated_play_pause.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../../entities/entities.dart';
import '../../../logic/song_bloc.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({
    super.key,
    this.width,
    this.height,
    this.iconSize,
  });

  final double? width;
  final double? height;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<SongBloc>().add(
                  state.isPlaying ? SongPauseEvent() : SongPlayEvent(),
                );
          },
          borderRadius: BorderRadius.circular(180),
          child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                color: ColorTheme.primary,
                shape: BoxShape.circle,
              ),
              child: AnimatedPlayPause(
                playing: state.isPlaying,
                color: Colors.white,
                size: iconSize,
              )),
        );
      },
    );
  }
}

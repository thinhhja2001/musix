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
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: ColorTheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              state.isPlaying ? Icons.pause : Icons.play_arrow,
              size: iconSize,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

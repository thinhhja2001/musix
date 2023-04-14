import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../config/exporter/state_exporter.dart';

import '../../../../config/exporter/bloc_exporter.dart';
import '../../../../theme/theme.dart';

class RepeatButtonWidget extends StatelessWidget {
  const RepeatButtonWidget({
    super.key,
    this.size,
  });
  final double? size;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<SongBloc>().add(SongSetLoopModeEvent());
          },
          icon: _buildIcon(state.loopMode, size),
        );
      },
    );
  }
}

Widget _buildIcon(LoopMode loopMode, double? size) {
  switch (loopMode) {
    case LoopMode.off:
      return Icon(
        Icons.repeat,
        size: size ?? 30,
        color: Colors.white,
      );
    case LoopMode.one:
      return Icon(
        Icons.repeat_one,
        size: size ?? 30,
        color: ColorTheme.primary,
      );
    case LoopMode.all:
      return Icon(
        Icons.repeat,
        size: size ?? 30,
        color: ColorTheme.primary,
      );
    default:
      return Icon(
        Icons.repeat,
        size: size ?? 30,
        color: Colors.white,
      );
  }
}

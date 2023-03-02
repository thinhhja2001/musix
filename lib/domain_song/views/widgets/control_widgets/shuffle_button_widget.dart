import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/theme/color.dart';

import '../../../../config/exporter/bloc_exporter.dart';
import '../../../../config/exporter/state_exporter.dart';

class ShuffleButtonWidget extends StatelessWidget {
  const ShuffleButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<SongBloc>().add(SongChangeShuffleModeEvent());
          },
          icon: Icon(
            Icons.shuffle,
            color: state.isShuffle ? ColorTheme.primary : Colors.white,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/exporter/bloc_exporter.dart';
import '../../../../config/exporter/state_exporter.dart';

class SkipToPreviousButtonWidget extends StatelessWidget {
  const SkipToPreviousButtonWidget({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<SongBloc>().add(SongPlayPreviousSongEvent());
            Future.delayed(const Duration(seconds: 1), () {
              context
                  .read<UserRecordBloc>()
                  .add(SaveUserSongRecordEvent(state.songInfo!));
            });
          },
          icon: Icon(
            Icons.skip_previous_rounded,
            color: Colors.white,
            size: size ?? 30,
          ),
        );
      },
    );
  }
}

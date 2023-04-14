import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/exporter/state_exporter.dart';

import '../../../../config/exporter/bloc_exporter.dart';

class SkipToNextButtonWidget extends StatelessWidget {
  const SkipToNextButtonWidget({super.key, this.size});
  final double? size;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<SongBloc>().add(SongPlayNextSongEvent());
          },
          icon: Icon(
            Icons.skip_next_rounded,
            size: size ?? 30,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

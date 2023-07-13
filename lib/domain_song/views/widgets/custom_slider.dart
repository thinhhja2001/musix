import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/color.dart';
import '../../../theme/text_style.dart';
import '../../../utils/utils.dart';
import '../../entities/entities.dart';
import '../../logic/song_bloc.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.draggable,
  });
  final bool draggable;

  @override
  Widget build(BuildContext context) {
    return draggable ? const _DraggableSlider() : const _NonDraggableSlider();
  }
}

class _NonDraggableSlider extends StatelessWidget {
  const _NonDraggableSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        final position = state.position;
        final duration = state.duration;
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              printDuration(position),
              style: TextStyleTheme.ts14.copyWith(
                color: ColorTheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: _CustomTrackShape(),
                  thumbShape: SliderComponentShape.noThumb,
                  thumbColor: ColorTheme.primary,
                ),
                child: Slider(
                  activeColor: ColorTheme.primary,
                  thumbColor: ColorTheme.primary,
                  value: position.inSeconds.toDouble(),
                  min: 0,
                  max: duration < position
                      ? position.inSeconds.toDouble()
                      : duration.inSeconds.toDouble(),
                  onChanged: (position) {},
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              printDuration(duration),
              style: TextStyleTheme.ts14.copyWith(
                color: ColorTheme.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DraggableSlider extends StatelessWidget {
  const _DraggableSlider();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongBloc, SongState>(
      builder: (context, state) {
        final position = state.position;
        final duration = state.duration;
        return ProgressBar(
          thumbColor: Colors.white,
          progressBarColor: ColorTheme.primary,
          thumbGlowColor: Colors.transparent,
          timeLabelTextStyle: TextStyleTheme.ts14.copyWith(
            fontWeight: FontWeight.w500,
          ),
          onSeek: (position) =>
              context.read<SongBloc>().add(SongOnSeekEvent(position)),
          thumbRadius: 8.0,
          progress: position,
          // We must plus the total duration to 5 because when the music ended,
          // the progress still count for a short amount of time.
          // which sometimes will violate the assert of (progress <= total)
          total: duration,
        );
      },
    );
  }
}

//This class is used for creating Slider without default padding on the horizontal
class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

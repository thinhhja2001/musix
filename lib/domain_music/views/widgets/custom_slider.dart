import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musix/theme/color.dart';
import 'package:musix/theme/text_style.dart';

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
  const _NonDraggableSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: _CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        thumbColor: ColorTheme.primary,
      ),
      child: Slider(
        activeColor: ColorTheme.primary,
        thumbColor: ColorTheme.primary,
        value: 20,
        min: 0,
        max: 100,
        onChanged: (value) {},
      ),
    );
  }
}

class _DraggableSlider extends StatelessWidget {
  const _DraggableSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      thumbColor: Colors.white,
      progressBarColor: ColorTheme.primary,
      thumbGlowColor: Colors.transparent,
      timeLabelTextStyle: TextStyleTheme.ts14.copyWith(
        fontWeight: FontWeight.w500,
      ),
      thumbRadius: 8.0,
      progress: const Duration(seconds: 50),
      total: const Duration(seconds: 100),
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

import 'package:flutter/material.dart';
import 'package:musix/domain_music/models/models.dart';
import 'package:musix/theme/theme.dart';

class CurrentSongPlayerWidget extends StatelessWidget {
  const CurrentSongPlayerWidget({super.key, required this.song});
  final Song song;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(color: Colors.black, blurRadius: 10),
                ]),
            child: CircleAvatar(
              backgroundImage: NetworkImage(song.thumbnailUrl),
              radius: 26,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Someone You Live",
                    style: TextStyleTheme.ts16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Ariana Grande",
                    style: TextStyleTheme.ts12.copyWith(
                      color: ColorTheme.primary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: CustomTrackShape(),
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
                  )
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shuffle,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
            backgroundColor: ColorTheme.primary,
            onPressed: () {},
            child: const Icon(Icons.play_arrow),
          )
        ],
      ),
    );
  }
}

//This class is used for creating Slider without default padding on the horizontal
class CustomTrackShape extends RoundedRectSliderTrackShape {
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

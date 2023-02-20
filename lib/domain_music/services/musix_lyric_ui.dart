import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import '../../theme/color.dart';

class MusixLyricUI extends LyricUI {
  double defaultSize;
  double defaultExtSize;
  double otherMainSize;
  double bias;
  double lineGap;
  double inlineGap;
  LyricAlign lyricAlign;
  LyricBaseLine lyricBaseLine;
  bool highlight;

  MusixLyricUI(
      {this.defaultSize = 18,
      this.defaultExtSize = 14,
      this.otherMainSize = 16,
      this.bias = 0.5,
      this.lineGap = 25,
      this.inlineGap = 25,
      this.lyricAlign = LyricAlign.LEFT,
      this.lyricBaseLine = LyricBaseLine.CENTER,
      this.highlight = true});

  MusixLyricUI.clone(MusixLyricUI customLyricUI)
      : this(
            defaultSize: customLyricUI.defaultSize,
            defaultExtSize: customLyricUI.defaultExtSize,
            otherMainSize: customLyricUI.otherMainSize,
            bias: customLyricUI.bias,
            lineGap: customLyricUI.lineGap,
            inlineGap: customLyricUI.inlineGap,
            lyricAlign: customLyricUI.lyricAlign,
            lyricBaseLine: customLyricUI.lyricBaseLine,
            highlight: customLyricUI.highlight);

  @override
  TextStyle getPlayingExtTextStyle() =>
      TextStyle(color: Colors.grey[300], fontSize: defaultExtSize);

  @override
  TextStyle getOtherExtTextStyle() => TextStyle(
        color: Colors.grey[300],
        fontSize: defaultExtSize,
      );

  @override
  TextStyle getOtherMainTextStyle() =>
      TextStyle(color: Colors.grey[200], fontSize: otherMainSize);

  @override
  TextStyle getPlayingMainTextStyle() => TextStyle(
        color: ColorTheme.primary,
        fontSize: defaultSize,
      );

  @override
  double getInlineSpace() => inlineGap;

  @override
  double getLineSpace() => lineGap;

  @override
  double getPlayingLineBias() => bias;

  @override
  LyricAlign getLyricHorizontalAlign() => lyricAlign;

  @override
  LyricBaseLine getBiasBaseLine() => lyricBaseLine;

  @override
  bool enableHighlight() => false;
  @override
  Color getLyricHightlightColor() {
    return ColorTheme.primary;
  }
}

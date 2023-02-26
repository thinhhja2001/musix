import 'package:equatable/equatable.dart';

class SongSource extends Equatable {
  final String? audioUrl;
  final String? lyricUrl;

  const SongSource({this.audioUrl, this.lyricUrl});

  @override
  List<Object?> get props => [
        audioUrl,
        lyricUrl,
      ];

  @override
  bool? get stringify => true;

  SongSource copyWith({String? audioUrl, String? lyricUrl}) {
    return SongSource(
      audioUrl: audioUrl ?? this.audioUrl,
      lyricUrl: lyricUrl ?? this.lyricUrl,
    );
  }
}

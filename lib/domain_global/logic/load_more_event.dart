import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/exporter/state_exporter.dart';
import '../../utils/enum/enum_music_type.dart';

late SearchMusicState state;
FutureOr _loadMoreVideo(
    SearchMusicVideoLoadMoreEvent event, Emitter emit) async {
  if (state.videos?.items?.isEmpty == true) {
    return;
  }
  if (state.currentPage![MusicType.video]! >= state.videos!.total!) {
    return;
  }
}

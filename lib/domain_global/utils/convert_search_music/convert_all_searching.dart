import 'package:musix/domain_artist/entities/artist/mini_artist.dart';
import 'package:musix/domain_global/entities/entities.dart';
import 'package:musix/domain_playlist/entities/entities.dart';
import 'package:musix/domain_song/entities/entities.dart';
import 'package:musix/domain_video/entities/video_short.dart';

SongInfo convertSongInfoFromAllSearching(AllSearching allSearching) {
  return SongInfo(
    encodeId: allSearching.id,
    title: allSearching.title,
    thumbnailM: allSearching.thumbnail,
    artistsNames: allSearching.artistsName,
  );
}

MiniArtist convertMiniArtistFromAllSearching(AllSearching allSearching) {
  return MiniArtist(
      id: allSearching.id,
      alias: allSearching.alias,
      name: allSearching.title,
      thumbnailM: allSearching.thumbnail);
}

MiniPlaylist convertMiniPlaylistFromAllSearching(AllSearching allSearching) {
  return MiniPlaylist(
    encodeId: allSearching.id,
    title: allSearching.title,
    artistsNames: allSearching.artistsName,
    thumbnailM: allSearching.thumbnail,
  );
}

VideoShort convertVideoShortFromAllSearching(AllSearching allSearching) {
  return VideoShort(
      encodeID: allSearching.id,
      title: allSearching.title,
      artistsNames: allSearching.artistsName,
      thumbnailM: allSearching.thumbnail);
}

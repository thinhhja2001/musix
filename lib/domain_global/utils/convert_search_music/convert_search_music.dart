import 'package:musix/domain_hub/entities/entities.dart';
import 'package:musix/domain_song/models/models.dart';
import 'package:musix/domain_song/utils/convert_model_entity/convert_song.dart';
import 'package:musix/domain_video/entities/video_short.dart';
import 'package:musix/domain_video/utils/convert_video.dart';
import 'package:musix/utils/enum/enum_music_type.dart';

import '../../../domain_artist/entities/entities.dart';
import '../../../domain_artist/models/models.dart';
import '../../../domain_artist/utils/convert_mini_artist.dart';
import '../../../domain_playlist/entities/entities.dart';
import '../../../domain_playlist/models/playlist/playlist_model.dart';
import '../../../domain_playlist/utils/convert_playlist/convert_mini_playlist.dart';
import '../../../domain_song/entities/entities.dart';
import '../../../domain_video/models/video_short_model.dart';
import '../../entities/entities.dart';
import '../../models/model.dart';

SectionAll convertSectionAllFromSearchAllModel(SearchAllModel model) {
  SectionAll sectionAll = const SectionAll(
    title: 'All',
    items: [],
  );
  List<AllSearching> list = [];

  if (model.data?.songs != null) {
    for (var i in model.data!.songs!) {
      list.add(convertAllSearchingFromSongModel(i));
    }
    list.shuffle();
  }

  if (model.data?.playlists != null) {
    for (var i in model.data!.playlists!) {
      list.add(convertAllSearchingFromPlaylistModel(i));
    }
    list.shuffle();
  }

  if (model.data?.artists != null) {
    for (var i in model.data!.artists!) {
      list.add(convertAllSearchingFromArtistModel(i));
    }
    list.shuffle();
  }

  if (list.isNotEmpty) {
    sectionAll = sectionAll.copyWith(
      items: list,
      total: list.length,
    );
  }
  return sectionAll;
}

SectionSong convertSectionSongFromSearchSongModel(SearchSongModel model) {
  SectionSong songs = const SectionSong(
    title: 'Top Songs',
    items: [],
  );
  List<SongInfo> list = [];
  int total = 0;
  if (model.data?.items != null) {
    for (var i in model.data!.items!) {
      list.add(convertSongInfoModel(i)!);
    }
    total = model.data!.total!;
  }
  if (list.isNotEmpty) {
    songs = songs.copyWith(
      items: list,
      total: total,
    );
  }
  return songs;
}

SectionVideo convertSectionVideoFromSearchVideoModel(SearchVideoModel model) {
  SectionVideo videos = const SectionVideo(title: "Top Videos", items: []);
  List<VideoShort> list = [];
  int total = 0;
  if (model.data?.items != null) {
    for (var i in model.data!.items!) {
      list.add(convertVideoShortModel(i));
    }
    total = model.data!.total!;
  }
  if (list.isNotEmpty) {
    videos = videos.copyWith(items: list, total: total);
  }
  return videos;
}

SectionPlaylist convertSectionPlaylistFromSearchPlaylistModel(
    SearchPlaylistModel model) {
  SectionPlaylist playlists = const SectionPlaylist(
    title: 'Top Playlists',
    items: [],
  );
  List<MiniPlaylist> list = [];
  int total = 0;
  if (model.data?.items != null) {
    for (var i in model.data!.items!) {
      list.add(convertMiniPlaylistFromPlaylistModel(i)!);
    }
    total = model.data!.total!;
  }
  if (list.isNotEmpty) {
    playlists = playlists.copyWith(
      items: list,
      total: total,
    );
  }
  return playlists;
}

SectionArtist convertSectionArtistFromSearchArtistModel(
    SearchArtistModel model) {
  SectionArtist artists = const SectionArtist(
    title: 'Top Artists',
    items: [],
  );
  List<MiniArtist> list = [];
  int total = 0;
  if (model.data?.items != null) {
    for (var i in model.data!.items!) {
      list.add(convertMiniArtist(i)!);
    }
    total = model.data!.total!;
  }
  if (list.isNotEmpty) {
    artists = artists.copyWith(
      items: list,
      total: total,
    );
  }
  return artists;
}

AllSearching convertAllSearchingFromSongModel(SongInfoModel model) {
  return AllSearching(
    id: model.encodeId,
    title: model.title,
    artistsName: model.artistsNames,
    thumbnail: model.thumbnailM,
    type: MusicType.song,
  );
}

AllSearching convertAllSearchingFromArtistModel(ArtistModel model) {
  return AllSearching(
    id: model.id,
    alias: model.alias,
    title: model.name,
    thumbnail: model.thumbnail ?? model.thumbnailM,
    type: MusicType.artist,
  );
}

AllSearching convertAllSearchingFromVideoModel(VideoShortModel model) {
  return AllSearching(
    id: model.encodeID,
    title: model.title,
    artistsName: model.artistsNames,
    thumbnail: model.thumbnailM,
    type: MusicType.video,
  );
}

AllSearching convertAllSearchingFromPlaylistModel(PlaylistModel model) {
  return AllSearching(
    id: model.encodeId,
    title: model.title,
    artistsName: model.artistsNames,
    thumbnail: model.thumbnail ?? model.thumbnailM,
    type: MusicType.playlist,
  );
}

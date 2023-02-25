import '../entities/artist/mini_artist.dart';
import '../models/get_artist_model/get_artist_model.dart';

MiniArtist? convertMiniArtist(ArtistModel? artistModel) {
  if (artistModel == null) return null;
  return MiniArtist(
    id: artistModel.id,
    name: artistModel.name,
    alias: artistModel.alias,
    thumbnailM: artistModel.thumbnailM,
  );
}

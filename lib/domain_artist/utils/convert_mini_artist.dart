import '../entities/artist/mini_artist.dart';
import '../models/models.dart';

MiniArtist? convertMiniArtist(ArtistModel? artistModel) {
  if (artistModel == null) return null;
  return MiniArtist(
    id: artistModel.id,
    name: artistModel.name,
    alias: artistModel.alias,
    thumbnailM: artistModel.thumbnailM,
  );
}

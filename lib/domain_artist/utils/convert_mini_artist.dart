import 'package:musix/domain_artist/entities/artist/mini_artist.dart';
import 'package:musix/domain_artist/models/get_artist_model/get_artist_model.dart';

MiniArtist? convertMiniArtist(ArtistModel? artistModel) {
  if (artistModel == null) return null;
  return MiniArtist(
    id: artistModel.id,
    name: artistModel.name,
    alias: artistModel.alias,
    thumbnailM: artistModel.thumbnailM,
  );
}

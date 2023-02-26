import '../../entities/entities.dart';
import '../../models/models.dart';

MiniArtist? convertMiniArtistFromModel(ArtistModel? artistModel) {
  if (artistModel == null) return null;
  return MiniArtist(
    id: artistModel.id,
    name: artistModel.name,
    alias: artistModel.alias,
    thumbnailM: artistModel.thumbnail,
  );
}

MiniArtist? convertMiniArtistFromJson(Map<String, dynamic> json) {
  final artistModel = ArtistModel.fromJson(json);
  return MiniArtist(
    id: artistModel.id,
    name: artistModel.name,
    alias: artistModel.alias,
    thumbnailM: artistModel.thumbnail,
  );
}

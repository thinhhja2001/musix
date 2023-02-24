import '../../entities/entities.dart';
import '../../model/model.dart';

Genre? convertGenre(GenresModel? genresModel) {
  if (genresModel == null) return null;
  return Genre(
    title: genresModel.title,
    id: genresModel.id,
    alias: genresModel.alias,
  );
}

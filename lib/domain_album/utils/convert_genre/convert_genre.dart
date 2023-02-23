

import '../../entities/genre/genre.dart';
import '../../models/genres/get_genre_model.dart';

Genre? convertGenre(GenresModel? genresModel){
  if (genresModel == null) return null;
  return Genre(
    title: genresModel.title,
    id: genresModel.id,
    alias: genresModel.alias,
  );
}

import '../entities/film_entity.dart';

abstract class FilmRepository {
  Future<List<FilmEntity>> getFilms();
  Future<FilmEntity> getFilmById(String id);
}

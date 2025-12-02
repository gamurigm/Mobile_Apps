import '../entities/film_entity.dart';

abstract class FilmRepository {
  Future<List<FilmEntity>> getFilms();
  Future<FilmEntity> getFilmById(String id);
  Future<List<FilmEntity>> getFilmsPaginated({int limit, int offset});
  Future<List<FilmEntity>> filterByDirector(String director);
  Future<List<FilmEntity>> filterByYear(String year);
}

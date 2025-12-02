import '../entities/film_entity.dart';
import 'base_repository.dart';

abstract class FilmRepository implements BaseRepository<FilmEntity> {
  @override
  Future<List<FilmEntity>> getAll();
  
  @override
  Future<FilmEntity?> getById(String id);
  
  // Método específico para mantener compatibilidad
  Future<List<FilmEntity>> getFilms() => getAll();
  Future<FilmEntity> getFilmById(String id) async {
    final film = await getById(id);
    if (film == null) {
      throw Exception('Film not found: $id');
    }
    return film;
  }
}

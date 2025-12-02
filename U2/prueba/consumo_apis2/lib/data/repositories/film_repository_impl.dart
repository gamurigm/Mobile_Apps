import '../../domain/entities/film_entity.dart';
import '../../domain/repositories/film_repository.dart';
import '../datasource/film_api_datasource.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmApiDataSource dataSource;

  FilmRepositoryImpl(this.dataSource);

  @override
  Future<List<FilmEntity>> getAll() async {
    try {
      return await dataSource.getFilms();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<FilmEntity?> getById(String id) async {
    try {
      return await dataSource.getFilmById(id);
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<List<FilmEntity>> getFilms() => getAll();

  @override
  Future<FilmEntity> getFilmById(String id) async {
    final film = await getById(id);
    if (film == null) {
      throw Exception('Film not found: $id');
    }
    return film;
  }
}

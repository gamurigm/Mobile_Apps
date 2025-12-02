import '../../domain/entities/film_entity.dart';
import '../../domain/repositories/film_repository.dart';
import '../datasource/film_api_datasource.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmApiDataSource dataSource;

  FilmRepositoryImpl(this.dataSource);

  @override
  Future<List<FilmEntity>> getFilms() async {
    try {
      return await dataSource.getFilms();
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }

  @override
  Future<FilmEntity> getFilmById(String id) async {
    try {
      return await dataSource.getFilmById(id);
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}

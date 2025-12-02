import '../../domain/entities/film_entity.dart';
import '../../domain/repositories/film_repository.dart';
import '../datasource/films_api_datasource.dart';
import '../models/film_model.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmsApiDataSource _dataSource;

  FilmRepositoryImpl(this._dataSource);

  @override
  Future<List<FilmEntity>> getFilms() async {
    try {
      final models = await _dataSource.fetchFilms();
      return models.map((model) => _modelToEntity(model)).toList();
    } catch (e) {
      throw Exception('Repository error getting films: $e');
    }
  }

  @override
  Future<FilmEntity> getFilmById(String id) async {
    try {
      final model = await _dataSource.fetchFilmById(id);
      return _modelToEntity(model);
    } catch (e) {
      throw Exception('Repository error getting film by id: $e');
    }
  }

  @override
  Future<List<FilmEntity>> getFilmsPaginated({int limit = 10, int offset = 0}) async {
    try {
      final models = await _dataSource.fetchFilmsPaginated(limit: limit, offset: offset);
      return models.map((model) => _modelToEntity(model)).toList();
    } catch (e) {
      throw Exception('Repository error getting paginated films: $e');
    }
  }

  @override
  Future<List<FilmEntity>> filterByDirector(String director) async {
    try {
      final models = await _dataSource.filterByDirector(director);
      return models.map((model) => _modelToEntity(model)).toList();
    } catch (e) {
      throw Exception('Repository error filtering by director: $e');
    }
  }

  @override
  Future<List<FilmEntity>> filterByYear(String year) async {
    try {
      final models = await _dataSource.filterByYear(year);
      return models.map((model) => _modelToEntity(model)).toList();
    } catch (e) {
      throw Exception('Repository error filtering by year: $e');
    }
  }

  FilmEntity _modelToEntity(FilmModel model) {
    return FilmEntity(
      id: model.id,
      title: model.title,
      originalTitle: model.originalTitle,
      originalTitleRomanised: model.originalTitleRomanised,
      image: model.image,
      movieBanner: model.movieBanner,
      description: model.description,
      director: model.director,
      producer: model.producer,
      releaseDate: model.releaseDate,
      runningTime: model.runningTime,
      rtScore: model.rtScore,
      people: model.people,
      species: model.species,
      locations: model.locations,
      vehicles: model.vehicles,
      url: model.url,
    );
  }
}

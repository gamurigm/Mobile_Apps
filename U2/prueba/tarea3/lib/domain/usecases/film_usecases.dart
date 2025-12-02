import '../entities/film_entity.dart';
import '../repositories/film_repository.dart';

class GetFilmsUseCase {
  final FilmRepository repository;

  GetFilmsUseCase(this.repository);

  Future<List<FilmEntity>> call() async {
    return await repository.getFilms();
  }
}

class GetFilmByIdUseCase {
  final FilmRepository repository;

  GetFilmByIdUseCase(this.repository);

  Future<FilmEntity> call(String id) async {
    return await repository.getFilmById(id);
  }
}

class GetFilmsPaginatedUseCase {
  final FilmRepository repository;

  GetFilmsPaginatedUseCase(this.repository);

  Future<List<FilmEntity>> call({int limit = 10, int offset = 0}) async {
    return await repository.getFilmsPaginated(limit: limit, offset: offset);
  }
}

class FilterFilmsByDirectorUseCase {
  final FilmRepository repository;

  FilterFilmsByDirectorUseCase(this.repository);

  Future<List<FilmEntity>> call(String director) async {
    return await repository.filterByDirector(director);
  }
}

class FilterFilmsByYearUseCase {
  final FilmRepository repository;

  FilterFilmsByYearUseCase(this.repository);

  Future<List<FilmEntity>> call(String year) async {
    return await repository.filterByYear(year);
  }
}

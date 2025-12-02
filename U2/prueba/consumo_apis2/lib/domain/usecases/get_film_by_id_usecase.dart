import '../entities/film_entity.dart';
import '../repositories/film_repository.dart';

class GetFilmByIdUseCase {
  final FilmRepository repository;

  GetFilmByIdUseCase(this.repository);

  Future<FilmEntity> call(String id) async {
    return await repository.getFilmById(id);
  }
}

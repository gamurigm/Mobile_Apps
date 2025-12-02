import '../entities/film_entity.dart';
import '../repositories/film_repository.dart';

class GetFilmsUseCase {
  final FilmRepository repository;

  GetFilmsUseCase(this.repository);

  Future<List<FilmEntity>> call() async {
    return await repository.getFilms();
  }
}

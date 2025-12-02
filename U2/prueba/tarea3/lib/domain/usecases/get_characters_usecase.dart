import '../entities/character_entity.dart';
import '../../data/repositories/base_repository.dart';

class GetCharactersUseCase {
  final BaseRepository repository;

  GetCharactersUseCase(this.repository);

  Future<List<CharacterEntity>> call() async {
    return await repository.getCharacters();
  }
}

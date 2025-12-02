import '../../domain/entities/character_entity.dart';

abstract class BaseRepository {
  Future<List<CharacterEntity>> getCharacters();
}

import '../datasource/characters_api_datasource.dart';
import '../models/character_model.dart';
import '../../domain/entities/character_entity.dart';
import 'base_repository.dart';

class CharacterRepositoryImpl implements BaseRepository {
  final CharactersApiDataSource _ds;

  CharacterRepositoryImpl(this._ds);

  @override
  Future<List<CharacterEntity>> getCharacters() async {
    final models = await _ds.fetchCharacters();
    return models.map((model) => _modelToEntity(model)).toList();
  }

  Future<CharacterModel> getCharacterById(int id) => _ds.fetchCharacterById(id);

  Future<CharacterModel> createCharacter(Map<String, dynamic> payload) => _ds.createCharacter(payload);

  CharacterEntity _modelToEntity(CharacterModel model) {
    return CharacterEntity(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      fullName: model.fullName,
      title: model.title,
      family: model.family,
      image: model.image,
      imageUrl: model.imageUrl,
    );
  }
}

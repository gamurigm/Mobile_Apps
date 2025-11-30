import '../../domain/entities/character.dart';
import '../datasources/base_datasource.dart';
import 'base_repository.dart';

class CharacterRepositoryImpl extends BaseRepository<CharacterEntity>{
  CharacterRepositoryImpl(BaseDatasource<CharacterEntity> datasource) 
  : super(datasource);
}
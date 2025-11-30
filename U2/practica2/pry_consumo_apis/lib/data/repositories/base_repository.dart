//usecases llama a repository
//repository llama a datasource
//datasource llama a la API

import '../../domain/entities/base_entity.dart';
import '../datasources/base_datasource.dart';

//llamar a la clase abstracta 

abstract class BaseRepository<T extends BaseEntity> {
  final BaseDatasource<T> datasource;
  BaseRepository(this.datasource);

  Future<List<T>> getAll() async {
    return await datasource.fetchData();
  }
}




import '../../data/repositories/base_repository.dart';

class DeleteProductoUsecase {
  final BaseRepository repository;

  DeleteProductoUsecase(this.repository);

  Future<bool> call(String id) {
    return repository.deleteProductos(id);
  }
}

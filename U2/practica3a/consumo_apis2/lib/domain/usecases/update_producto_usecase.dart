import '../entities/producto_entity.dart';
import '../../data/repositories/base_repository.dart';

class UpdateProductoUsecase {
  final BaseRepository repository;

  UpdateProductoUsecase(this.repository);

  Future<ProductoEntity> call(String id, ProductoEntity producto) {
    return repository.updateProductos(id, producto);
  }
}
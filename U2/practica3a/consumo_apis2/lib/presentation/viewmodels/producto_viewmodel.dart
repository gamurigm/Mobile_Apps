import 'package:consumo_apis2/domain/usecases/create_producto_usecase.dart';
import 'package:consumo_apis2/domain/usecases/delete_producto_usecase.dart';
import 'package:consumo_apis2/domain/usecases/update_producto_usecase.dart';

import '../../domain/entities/producto_entity.dart';
import '../../domain/usecases/getproductos_usecase.dart';
import 'base_viewmodel.dart';

class ProductoViewModel extends BaseViewModel {
  final GetProductosUseCase usecase;
  final CreateProductosUseCase createUsecase;
  final UpdateProductoUsecase updateUsecase;
  final DeleteProductoUsecase deleteUsecase;

  List<ProductoEntity> productos = [];

  ProductoViewModel({
    required this.usecase,
    required this.createUsecase,
    required this.updateUsecase,
    required this.deleteUsecase,
  });

  Future<void> cargarProductos() async {
    setLoading(true);
    try {
      productos = await usecase();
    } catch (e) {
      // Handle error appropriately, e.g., log it or show a message
      print("Error loading products: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> createProductos(ProductoEntity producto) async {
    await createUsecase(producto);
    await cargarProductos();
  }

  Future<void> updateProductos(String id, ProductoEntity producto) async {
    await updateUsecase(id, producto);
    await cargarProductos();
  }

  Future<void> deleteProductos(String id) async {
    await deleteUsecase(id);
    await cargarProductos();
  }
}

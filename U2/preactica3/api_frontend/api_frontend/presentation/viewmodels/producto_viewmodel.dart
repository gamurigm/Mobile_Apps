import '../../domain/entities/producto_entity.dart';
import '../../domain/usecases/get_productos_usecase.dart';
import 'base_viewmodel.dart';

class ProductoViewModel extends BaseViewModel {
  final GetProductosUseCase usecase;

  List<ProductoEntity> productos = [];

  ProductoViewModel(this.usecase);

  Future<void> cargarProductos() async {
    setLoading(true);
    productos = await usecase();
    setLoading(false);
  }
}

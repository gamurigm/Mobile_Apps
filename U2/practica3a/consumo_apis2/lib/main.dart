import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/viewmodels/producto_viewmodel.dart';
import 'domain/usecases/getproductos_usecase.dart';
import 'domain/usecases/create_producto_usecase.dart';
import 'domain/usecases/update_producto_usecase.dart';
import 'domain/usecases/delete_producto_usecase.dart';
import 'data/repositories/producto_repository_impl.dart';
import 'data/datasource/producto_api_datasource.dart';

import 'presentation/routes/app_routes.dart';
import 'presentation/views/theme/tema_general.dart';

void main() {
  // Inyección de dependencias
  final dataSource = ProductoApiDataSource();
  final repo = ProductoRepositoryImpl(dataSource);
  final getUseCase = GetProductosUseCase(repo);
  final createUseCase = CreateProductosUseCase(repo);
  final updateUseCase = UpdateProductoUsecase(repo);
  final deleteUseCase = DeleteProductoUsecase(repo);

  runApp(
    MyApp(
      getUseCase: getUseCase,
      createUseCase: createUseCase,
      updateUseCase: updateUseCase,
      deleteUseCase: deleteUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetProductosUseCase getUseCase;
  final CreateProductosUseCase createUseCase;
  final UpdateProductoUsecase updateUseCase;
  final DeleteProductoUsecase deleteUseCase;

  const MyApp({
    super.key,
    required this.getUseCase,
    required this.createUseCase,
    required this.updateUseCase,
    required this.deleteUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductoViewModel(
            usecase: getUseCase,
            createUsecase: createUseCase,
            updateUsecase: updateUseCase,
            deleteUsecase: deleteUseCase,
          )..cargarProductos(),
        ),
      ],
      child: MaterialApp(
        title: "Consumo API Flutter",
        debugShowCheckedModeBanner: false,
        theme: TemaGeneral.temaClaro,
        darkTheme: TemaGeneral.temaOscuro,
        themeMode: ThemeMode.light,
        routes: AppRoutes.routes,
      ),
    );
  }
}

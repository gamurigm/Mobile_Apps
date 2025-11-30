import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pry_arquitectura_limpia/src/domain/usecases/calcular_aumento.dart';
import 'src/presentation/routes/app_routes.dart';
import 'src/presentation/viewsmodels/operario_viewmodel.dart';

//se inicializa, y se usa el provider 
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => OperarioViewModel(CalcularAumentoUseCases()),
      child: MyApp(),
    )
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Operario Aumento Salario App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }


}
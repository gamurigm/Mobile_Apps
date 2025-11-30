import 'package:flutter/material.dart';
import 'package:pry_arquitectura_limpia/src/presentation/views/home_page.dart';
import 'package:pry_arquitectura_limpia/src/presentation/views/result_page.dart';
import 'package:pry_arquitectura_limpia/src/domain/entities/resultado_operario.dart';
import 'package:pry_arquitectura_limpia/src/domain/entities/operario.dart';

class AppRoutes {
  static const String home = '/';
  static const String result = '/result';

  static Map<String, WidgetBuilder> routes = {
    home: (_) => const HomePage(),
    result: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final resultado = args != null && args['resultado'] != null
          ? args['resultado'] as ResultadoOperario
          : ResultadoOperario(aumento: 0, sueldoFinal: 0);
      final operario = args != null && args['operario'] != null
          ? args['operario'] as Operario
          : Operario(sueldo: 0, antiguedad: 0);
      return ResultPage(operario: operario, resultado: resultado);
    }
  };
}
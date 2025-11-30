import 'package:flutter/material.dart';
import '../../domain/usecases/calcular_aumento.dart';
import '../../domain/entities/resultado_operario.dart';
import '../../domain/entities/operario.dart';
//interfaz para ingresar los datos del operario por tanto se comunica con useCases



class OperarioViewModel extends ChangeNotifier {
  final CalcularAumentoUseCases _calcularAumentoUseCases;

  OperarioViewModel(this._calcularAumentoUseCases);

  ResultadoOperario?  resultado;



  ResultadoOperario calcular(double sueldo, int antiguedad ){
    final operario = Operario(sueldo: sueldo, antiguedad: antiguedad);
    resultado = _calcularAumentoUseCases.ejecutar(operario);

    notifyListeners();
    return resultado!;

  } 
}
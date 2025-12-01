import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class FondosApp {
  static const BoxDecoration degradadoPrincipal = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        AppColors.primario,
        AppColors.acento,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  static const BoxDecoration fondoclaro = BoxDecoration(
    color: AppColors.txtClaro,
  );

  static const BoxDecoration fondoOscuro = BoxDecoration(
    color: Colors.deepPurple,  
  );

}
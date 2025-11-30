import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class TemaAppBar {
  // 🎨 AppBar moderno con diseño flat
  static const AppBarTheme temaAppBar = AppBarTheme(
    backgroundColor: AppColors.primario,
    foregroundColor: AppColors.txtClaro,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    elevation: 0, // Diseño flat moderno
    scrolledUnderElevation: 2, // Sombra sutil al hacer scroll
    shadowColor: AppColors.sombraMedia,

    // Estilo del título
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      color: AppColors.txtClaro,
    ),

    // Estilo de los iconos
    iconTheme: IconThemeData(color: AppColors.txtClaro, size: 24),

    actionsIconTheme: IconThemeData(color: AppColors.txtClaro, size: 24),
  );

  /*
  ✨ AppBar moderno 2024
  🎯 Características:
    - Diseño flat sin elevación
    - Sombra sutil al hacer scroll
    - Tipografía optimizada
    - Colores vibrantes
    - Iconos bien dimensionados
  */
}

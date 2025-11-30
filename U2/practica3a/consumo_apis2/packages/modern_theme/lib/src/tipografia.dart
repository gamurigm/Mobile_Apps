import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class TipografiaApp {
  // 🎨 Tipografía moderna y profesional
  // Usando la fuente del sistema con pesos optimizados

  static const TextTheme texto = TextTheme(
    // Títulos grandes y modernos
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -1.0, // Estilo moderno "tight"
      color: AppColors.txtPrincipal,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      color: AppColors.txtPrincipal,
    ),
    displaySmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      color: AppColors.txtPrincipal,
    ),

    // Títulos de secciones
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700, // Semi-bold fuerte
      letterSpacing: 0.15,
      color: AppColors.txtPrincipal,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: AppColors.txtPrincipal,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: AppColors.txtSecundario,
    ),

    // Cuerpo de texto legible
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5, // Mejor lectura
      color: AppColors.txtPrincipal,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.4,
      color: AppColors.txtPrincipal,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.4,
      color: AppColors.txtSecundario,
    ),

    // Etiquetas
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: AppColors.txtPrincipal,
    ),
  );
}

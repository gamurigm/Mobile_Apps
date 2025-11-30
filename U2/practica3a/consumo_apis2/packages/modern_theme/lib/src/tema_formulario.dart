import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class TemaFormulario {
  // 🎨 Campos de texto modernos con mejor UX
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.fondoSecundario,

    // Estilo de etiquetas
    labelStyle: const TextStyle(
      color: AppColors.txtSecundario,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    floatingLabelStyle: const TextStyle(
      color: AppColors.primario,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),

    // Estilo de hint
    hintStyle: const TextStyle(
      color: AppColors.txtTerciario,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),

    // Estilo de texto de ayuda
    helperStyle: const TextStyle(color: AppColors.txtSecundario, fontSize: 12),

    // Estilo de error
    errorStyle: const TextStyle(
      color: AppColors.error,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),

    // Iconos
    prefixIconColor: AppColors.primario,
    suffixIconColor: AppColors.txtSecundario,

    // Padding interno
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

    // Borde cuando está habilitado (estado normal)
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borde, width: 1.5),
    ),

    // Borde cuando tiene foco
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.bordeFocus, width: 2),
    ),

    // Borde cuando hay error
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
    ),

    // Borde cuando hay error y tiene foco
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),

    // Borde cuando está deshabilitado
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.bordeSecundario, width: 1),
    ),

    // Configuración adicional
    isDense: false,
    isCollapsed: false,
  );

  /*
  ✨ Formularios modernos 2024
  🎯 Características:
    - Bordes redondeados suaves
    - Colores de estado claros
    - Feedback visual inmediato
    - Padding generoso
    - Transiciones suaves
    - Accesibilidad mejorada
  */
}

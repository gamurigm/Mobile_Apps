import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class TemaFormulario {
  static final campoTexto = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.fondoSecundario,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    labelStyle: const TextStyle(
      color: AppColors.txtSecundario,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    hintStyle: const TextStyle(
      color: AppColors.txtTerciario,
      fontSize: 14,
    ),
    prefixIconColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return AppColors.primario;
      }
      return AppColors.txtTerciario;
    }),
    suffixIconColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return AppColors.primario;
      }
      return AppColors.txtTerciario;
    }),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.borde,
        width: 1.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.primario,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.error,
        width: 1.5,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.bordeSecundario,
        width: 1.5,
      ),
    ),
    errorStyle: const TextStyle(
      color: AppColors.error,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  );
}


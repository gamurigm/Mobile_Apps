import 'package:flutter/material.dart';
import 'colores_esquema.dart';

class TemaBoton {
  // 🎨 Botón principal elevado - Moderno con gradiente sutil
  static final botonPrincipal = ElevatedButtonThemeData(
    style:
        ElevatedButton.styleFrom(
          backgroundColor: AppColors.primario,
          foregroundColor: AppColors.txtClaro,
          elevation: 0, // Flat design moderno
          shadowColor: AppColors.sombraMedia,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordes más suaves
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ).copyWith(
          // Efecto hover/pressed moderno
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primarioOscuro.withOpacity(0.2);
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primarioClaro.withOpacity(0.1);
            }
            return null;
          }),
          elevation: WidgetStateProperty.resolveWith<double>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return 0;
            }
            if (states.contains(WidgetState.hovered)) {
              return 4;
            }
            return 2;
          }),
        ),
  );

  // 🎨 Botón secundario outlined - Minimalista y elegante
  static final botonSecundario = OutlinedButtonThemeData(
    style:
        OutlinedButton.styleFrom(
          foregroundColor: AppColors.primario,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          side: const BorderSide(color: AppColors.primario, width: 1.5),
        ).copyWith(
          // Efecto hover moderno
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primario.withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primario.withOpacity(0.05);
            }
            return Colors.transparent;
          }),
          side: WidgetStateProperty.resolveWith<BorderSide>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return const BorderSide(
                color: AppColors.primarioOscuro,
                width: 2,
              );
            }
            if (states.contains(WidgetState.hovered)) {
              return const BorderSide(
                color: AppColors.primarioClaro,
                width: 1.5,
              );
            }
            return const BorderSide(color: AppColors.primario, width: 1.5);
          }),
        ),
  );

  // 🎨 Botón de texto - Minimalista
  static final botonTexto = TextButtonThemeData(
    style:
        TextButton.styleFrom(
          foregroundColor: AppColors.primario,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primario.withOpacity(0.15);
            }
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primario.withOpacity(0.08);
            }
            return null;
          }),
        ),
  );

  /*
  ✨ Botones modernos 2024
  🎯 Características:
    - Diseño flat con elevación sutil
    - Efectos hover/pressed suaves
    - Bordes redondeados modernos
    - Padding generoso para mejor UX
    - Tipografía optimizada
  */
}

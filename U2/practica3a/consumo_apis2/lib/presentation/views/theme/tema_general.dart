import 'package:flutter/material.dart';
import 'tipografia.dart';
import 'colores_esquema.dart';
import 'tema_appbar.dart';
import 'tema_formulario.dart';
import 'tema_boton.dart';

class TemaGeneral {
  // 🎨 Tema ultra moderno Material Design 3
  static ThemeData temaClaro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Esquema de colores personalizado
    colorScheme: const ColorScheme.light(
      primary: AppColors.primario,
      onPrimary: AppColors.txtClaro,
      primaryContainer: AppColors.primarioClaro,
      onPrimaryContainer: AppColors.primarioOscuro,
      
      secondary: AppColors.secundario,
      onSecondary: AppColors.txtClaro,
      secondaryContainer: AppColors.secundarioClaro,
      onSecondaryContainer: AppColors.secundarioOscuro,
      
      tertiary: AppColors.terciario,
      onTertiary: AppColors.txtClaro,
      tertiaryContainer: AppColors.terciarioClaro,
      onTertiaryContainer: AppColors.terciarioOscuro,
      
      error: AppColors.error,
      onError: AppColors.txtClaro,
      errorContainer: Color(0xFFFEE2E2),
      onErrorContainer: AppColors.error,
      
      surface: AppColors.superficie,
      onSurface: AppColors.txtPrincipal,
      surfaceContainerHighest: AppColors.fondoSecundario,
      
      outline: AppColors.borde,
      outlineVariant: AppColors.bordeSecundario,
      shadow: AppColors.sombra,
      scrim: AppColors.overlay,
    ),
    
    // Tipografía moderna
    textTheme: TipografiaApp.texto,
    
    // AppBar personalizado
    appBarTheme: TemaAppBar.temaAppBar,
    
    // Botones personalizados
    elevatedButtonTheme: TemaBoton.botonPrincipal,
    outlinedButtonTheme: TemaBoton.botonSecundario,
    textButtonTheme: TemaBoton.botonTexto,
    
    // Formularios personalizados
    inputDecorationTheme: TemaFormulario.campoTexto,
    
    // Fondo general
    scaffoldBackgroundColor: AppColors.fondoClaro,
    
    // Tarjetas modernas
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.superficie,
      surfaceTintColor: AppColors.primario.withOpacity(0.05),
      shadowColor: AppColors.sombraMedia,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borde, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // FAB moderno
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primario,
      foregroundColor: AppColors.txtClaro,
      elevation: 4,
      highlightElevation: 8,
      shape: CircleBorder(),
    ),
    
    // Divisores
    dividerTheme: const DividerThemeData(
      color: AppColors.borde,
      thickness: 1,
      space: 1,
    ),
    
    // Iconos
    iconTheme: const IconThemeData(
      color: AppColors.txtPrincipal,
      size: 24,
    ),
    
    // Chips modernos
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.fondoSecundario,
      selectedColor: AppColors.primario,
      secondarySelectedColor: AppColors.secundario,
      labelStyle: const TextStyle(
        color: AppColors.txtPrincipal,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: AppColors.txtClaro,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.borde),
      ),
    ),
    
    // Diálogos modernos
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.superficie,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: AppColors.sombraFuerte,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.txtPrincipal,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14,
        color: AppColors.txtSecundario,
      ),
    ),
    
    // Bottom sheets modernos
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.superficie,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      showDragHandle: true,
    ),
    
    // Snackbars modernos
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.txtPrincipal,
      contentTextStyle: const TextStyle(
        color: AppColors.txtClaro,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),
  );
}


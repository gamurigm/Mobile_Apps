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
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.sombraMedia,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borde, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // FAB moderno
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primario,
      foregroundColor: AppColors.txtClaro,
      elevation: 4,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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

  // 🌃 Tema Oscuro Neon Moderno
  static ThemeData temaOscuro = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    
    // Esquema de colores Neon
    colorScheme: const ColorScheme.dark(
      primary: AppColors.neonPrimario,
      onPrimary: AppColors.fondoNeon,
      primaryContainer: AppColors.primarioOscuro,
      onPrimaryContainer: AppColors.neonPrimario,
      
      secondary: AppColors.neonSecundario,
      onSecondary: AppColors.fondoNeon,
      secondaryContainer: AppColors.secundarioOscuro,
      onSecondaryContainer: AppColors.neonSecundario,
      
      tertiary: AppColors.neonTerciario,
      onTertiary: AppColors.fondoNeon,
      tertiaryContainer: AppColors.terciarioOscuro,
      onTertiaryContainer: AppColors.neonTerciario,
      
      error: AppColors.neonError,
      onError: AppColors.fondoNeon,
      errorContainer: Color(0xFF450A0A),
      onErrorContainer: AppColors.neonError,
      
      surface: AppColors.superficieNeon,
      onSurface: AppColors.txtOscuroClaro,
      surfaceContainerHighest: AppColors.bordeNeon,
      
      outline: AppColors.bordeNeon,
      outlineVariant: AppColors.bordeNeon,
      shadow: Colors.black,
      scrim: Colors.black54,
    ),
    
    // Tipografía adaptada a oscuro
    textTheme: TipografiaApp.texto.apply(
      bodyColor: AppColors.txtOscuroClaro,
      displayColor: AppColors.txtOscuroClaro,
    ),
    
    // AppBar Oscuro
    appBarTheme: TemaAppBar.temaAppBar.copyWith(
      backgroundColor: AppColors.fondoNeon,
      foregroundColor: AppColors.txtOscuroClaro,
      surfaceTintColor: Colors.transparent,
    ),
    
    // Botones adaptados
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.neonPrimario,
        foregroundColor: AppColors.fondoNeon,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.neonPrimario,
        side: const BorderSide(color: AppColors.neonPrimario),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    
    // Fondo general oscuro
    scaffoldBackgroundColor: AppColors.fondoNeon,
    
    // Tarjetas oscuras
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.superficieNeon,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.bordeNeon, width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    
    // FAB Oscuro
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.neonPrimario,
      foregroundColor: AppColors.fondoNeon,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    
    // Divisores oscuros
    dividerTheme: const DividerThemeData(
      color: AppColors.bordeNeon,
      thickness: 1,
      space: 1,
    ),
    
    // Iconos oscuros
    iconTheme: const IconThemeData(
      color: AppColors.txtOscuroClaro,
      size: 24,
    ),
    
    // Inputs oscuros
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.superficieNeon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.bordeNeon),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.bordeNeon),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neonPrimario, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.neonError),
      ),
      labelStyle: const TextStyle(color: AppColors.txtOscuroClaro),
      hintStyle: TextStyle(color: AppColors.txtOscuroClaro.withOpacity(0.5)),
    ),

    // Dialogs oscuros
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.superficieNeon,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.txtOscuroClaro,
      ),
      contentTextStyle: TextStyle(
        fontSize: 14,
        color: AppColors.txtOscuroClaro,
      ),
    ),
  );
}


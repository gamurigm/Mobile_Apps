import 'package:flutter/material.dart';

class AppColors {
  // 🎨 Paleta de colores ultra moderna - Inspirada en diseños 2024

  // Colores primarios con gradientes vibrantes
  static const Color primario = Color(0xFF6366F1); // Indigo vibrante
  static const Color primarioClaro = Color(0xFF818CF8); // Indigo claro
  static const Color primarioOscuro = Color(0xFF4F46E5); // Indigo oscuro

  static const Color secundario = Color(0xFFEC4899); // Rosa fucsia moderno
  static const Color secundarioClaro = Color(0xFFF472B6); // Rosa claro
  static const Color secundarioOscuro = Color(0xFFDB2777); // Rosa oscuro

  static const Color terciario = Color(0xFF14B8A6); // Teal vibrante
  static const Color terciarioClaro = Color(0xFF2DD4BF); // Teal claro
  static const Color terciarioOscuro = Color(0xFF0D9488); // Teal oscuro

  // Colores de acento y estado con tonos modernos
  static const Color acento = Color(0xFFF59E0B); // Ámbar dorado
  static const Color acentoClaro = Color(0xFFFBBF24); // Ámbar claro

  static const Color exito = Color(0xFF10B981); // Verde esmeralda
  static const Color exitoClaro = Color(0xFF34D399); // Verde claro

  static const Color error = Color(0xFFEF4444); // Rojo coral
  static const Color errorClaro = Color(0xFFF87171); // Rojo claro

  static const Color advertencia = Color(0xFFF97316); // Naranja vibrante
  static const Color advertenciaClaro = Color(0xFFFB923C); // Naranja claro

  static const Color informacion = Color(0xFF3B82F6); // Azul brillante
  static const Color informacionClaro = Color(0xFF60A5FA); // Azul claro

  // Paleta de texto moderna con mejor contraste
  static const Color txtPrincipal = Color(0xFF0F172A); // Casi negro azulado
  static const Color txtSecundario = Color(0xFF475569); // Gris azulado medio
  static const Color txtTerciario = Color(0xFF94A3B8); // Gris azulado claro
  static const Color txtDesactivado = Color(0xFFCBD5E1); // Gris muy claro
  static const Color txtClaro = Color(0xFFFAFAFA); // Blanco casi puro
  static const Color txtOscuro = Color(0xFF1E293B); // Gris oscuro azulado
  static const Color txtOscuroClaro = Color(
    0xFFE2E8F0,
  ); // Gris claro para modo oscuro

  // Fondos modernos con profundidad
  static const Color fondoClaro = Color(0xFFFAFAFA); // Blanco cálido
  static const Color fondoSecundario = Color(
    0xFFF1F5F9,
  ); // Gris azulado muy claro
  static const Color fondoTerciario = Color(0xFFE2E8F0); // Gris azulado claro
  static const Color superficie = Color(0xFFFFFFFF); // Blanco puro
  static const Color superficieElevada = Color(0xFFFEFEFE); // Blanco elevado

  // Fondos oscuros para dark mode
  static const Color fondoOscuro = Color(0xFF0F172A); // Azul muy oscuro
  static const Color fondoOscuroSecundario = Color(0xFF1E293B); // Azul oscuro
  static const Color superficieOscura = Color(
    0xFF334155,
  ); // Gris azulado oscuro
  static const Color superficieOscuraElevada = Color(
    0xFF475569,
  ); // Gris azulado medio

  // Bordes y divisores modernos
  static const Color borde = Color(0xFFE2E8F0); // Gris azulado claro
  static const Color bordeSecundario = Color(0xFFCBD5E1); // Gris azulado medio
  static const Color bordeFocus = Color(0xFF6366F1); // Indigo para focus
  static const Color bordeError = Color(0xFFEF4444); // Rojo para errores

  // Sombras con diferentes intensidades
  static const Color sombra = Color(0x0A000000); // Sombra muy suave
  static const Color sombraMedia = Color(0x1A000000); // Sombra media
  static const Color sombraFuerte = Color(0x29000000); // Sombra fuerte

  // Colores para glassmorphism y efectos modernos
  static const Color glassFondo = Color(0xCCFFFFFF); // Blanco semi-transparente
  static const Color glassFondoOscuro = Color(
    0xCC1E293B,
  ); // Oscuro semi-transparente
  static const Color overlay = Color(0x80000000); // Overlay oscuro
  static const Color overlayClaro = Color(0x40000000); // Overlay claro

  // Gradientes modernos
  static const LinearGradient gradientePrimario = LinearGradient(
    colors: [primario, primarioClaro],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteSecundario = LinearGradient(
    colors: [secundario, secundarioClaro],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteTerciario = LinearGradient(
    colors: [terciario, terciarioClaro],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteVibrante = LinearGradient(
    colors: [primario, secundario, terciario],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradienteSutil = LinearGradient(
    colors: [fondoClaro, fondoSecundario],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /*
  🚀 Paleta ultra moderna 2024
  ✨ Inspirada en: Vercel, Linear, Stripe, Notion
  🎯 Características:
    - Colores vibrantes pero profesionales
    - Excelente contraste y accesibilidad
    - Soporte completo para dark mode
    - Gradientes y efectos glassmorphism
    - Perfecta para aplicaciones modernas
  */
}

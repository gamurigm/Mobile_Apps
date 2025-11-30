# 🎨 Tema Moderno - Consumo APIs 2

## Descripción
Sistema de diseño ultra moderno implementado para la aplicación de consumo de APIs. Inspirado en los mejores sistemas de diseño de 2024 como Vercel, Linear, Stripe y Notion.

## 📁 Estructura de Archivos

```
lib/presentation/views/theme/
├── colores_esquema.dart    # Paleta de colores completa
├── tipografia.dart          # Sistema tipográfico
├── tema_appbar.dart         # Tema del AppBar
├── tema_boton.dart          # Temas de botones
├── tema_formulario.dart     # Temas de formularios
├── tema_bg.dart             # Fondos y degradados
└── tema_general.dart        # Tema principal que integra todo
```

## 🎨 Paleta de Colores

### Colores Primarios
- **Primario**: Indigo vibrante (#6366F1)
- **Secundario**: Rosa fucsia moderno (#EC4899)
- **Terciario**: Teal vibrante (#14B8A6)

### Colores de Estado
- **Éxito**: Verde esmeralda (#10B981)
- **Error**: Rojo coral (#EF4444)
- **Advertencia**: Naranja vibrante (#F97316)
- **Información**: Azul brillante (#3B82F6)

### Colores de Texto
- **Principal**: Casi negro azulado (#0F172A)
- **Secundario**: Gris azulado medio (#475569)
- **Terciario**: Gris azulado claro (#94A3B8)
- **Claro**: Blanco casi puro (#FAFAFA)

## ✨ Características Principales

### 1. **Material Design 3**
- Uso completo de Material Design 3
- Componentes modernos y actualizados
- Soporte para estados interactivos

### 2. **Diseño Flat Moderno**
- Elevaciones sutiles
- Bordes redondeados (8-20px)
- Sombras suaves y profesionales

### 3. **Tipografía Optimizada**
- Jerarquía visual clara
- Espaciado (letter-spacing) optimizado
- Altura de línea profesional
- Pesos de fuente balanceados

### 4. **Componentes Personalizados**

#### Botones
- **Elevado**: Diseño flat con efectos hover
- **Outlined**: Minimalista y elegante
- **Texto**: Sutil y discreto

#### Formularios
- Bordes redondeados (12px)
- Colores de estado claros
- Feedback visual inmediato
- Padding generoso

#### Tarjetas
- Elevación 0 (flat design)
- Bordes sutiles
- Bordes redondeados (16px)
- Tinte de superficie sutil

#### AppBar
- Diseño flat sin elevación
- Sombra sutil al hacer scroll
- Tipografía optimizada

### 5. **Efectos Modernos**
- Transiciones suaves
- Estados hover/pressed
- Overlays con opacidad
- Glassmorphism ready

## 🚀 Uso

### En main.dart

```dart
import 'presentation/views/theme/tema_general.dart';

MaterialApp(
  theme: TemaGeneral.temaClaro,
  themeMode: ThemeMode.light,
  // ...
)
```

### Acceder a Colores

```dart
import 'package:consumo_apis2/presentation/views/theme/colores_esquema.dart';

Container(
  color: AppColors.primario,
  child: Text(
    'Hola',
    style: TextStyle(color: AppColors.txtClaro),
  ),
)
```

### Usar Tipografía

```dart
Text(
  'Título Principal',
  style: Theme.of(context).textTheme.displayLarge,
)

Text(
  'Cuerpo de texto',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

## 🎯 Componentes Incluidos

- ✅ AppBar
- ✅ Botones (Elevated, Outlined, Text)
- ✅ Campos de texto
- ✅ Tarjetas (Cards)
- ✅ FAB (Floating Action Button)
- ✅ Diálogos
- ✅ Bottom Sheets
- ✅ Snackbars
- ✅ Chips
- ✅ Switches
- ✅ Checkboxes
- ✅ Radio Buttons
- ✅ Sliders
- ✅ Progress Indicators
- ✅ Divisores

## 📱 Responsive

El tema está optimizado para:
- Teléfonos móviles
- Tablets
- Diferentes densidades de pantalla

## 🌙 Dark Mode

Actualmente implementado en modo claro. El dark mode puede ser agregado fácilmente creando `temaOscuro` en `tema_general.dart`.

## 🎨 Personalización

Para personalizar los colores:
1. Edita `colores_esquema.dart`
2. Los cambios se reflejarán automáticamente en toda la app

Para personalizar la tipografía:
1. Edita `tipografia.dart`
2. Ajusta tamaños, pesos y espaciados

## 📝 Notas

- Todos los componentes usan `const` cuando es posible para optimización
- Los colores están organizados por categorías
- La tipografía sigue las mejores prácticas de Material Design
- El tema es completamente modular y fácil de mantener

## 🔄 Versión

- **Versión**: 1.0.0
- **Última actualización**: 2025-11-28
- **Flutter**: Compatible con Flutter 3.x

---

**Creado con ❤️ para una experiencia de usuario excepcional**

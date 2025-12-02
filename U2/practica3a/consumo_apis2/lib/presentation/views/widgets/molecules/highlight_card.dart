import 'package:flutter/material.dart';
import '../atoms/atoms.dart';

/// Molecule genérica para tarjetas con valores destacados
/// Útil para mostrar KPIs, precios, totales, etc.
class HighlightCard extends StatelessWidget {
  final String title;
  final String value;
  final HighlightStyle style;
  final Color? primaryColor;
  final Color? secondaryColor;
  final IconData? icon;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const HighlightCard({
    super.key,
    required this.title,
    required this.value,
    this.style = HighlightStyle.gradient,
    this.primaryColor,
    this.secondaryColor,
    this.icon,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 4),
        child: HighlightValue(
          value: value,
          label: title,
          style: style,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
          icon: icon,
        ),
      ),
    );
  }
}

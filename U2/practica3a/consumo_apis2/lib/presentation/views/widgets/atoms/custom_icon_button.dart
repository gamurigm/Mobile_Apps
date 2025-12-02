import 'package:flutter/material.dart';
import '../../theme/colores_esquema.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final Color? color;
  final double size;
  final EdgeInsetsGeometry? padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.color,
    this.size = 24,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed,
      tooltip: tooltip,
      color: color,
      padding: padding,
    );
  }
}

import 'package:flutter/material.dart';

/// Átomo genérico para mostrar valores destacados
/// Puede usarse para precio, fecha, estado, etc.
enum HighlightStyle { gradient, solid, outlined }

class HighlightValue extends StatelessWidget {
  final String value;
  final String? label;
  final HighlightStyle style;
  final Color? primaryColor;
  final Color? secondaryColor;
  final IconData? icon;
  final TextStyle? valueTextStyle;
  final TextStyle? labelTextStyle;

  const HighlightValue({
    super.key,
    required this.value,
    this.label,
    this.style = HighlightStyle.gradient,
    this.primaryColor,
    this.secondaryColor,
    this.icon,
    this.valueTextStyle,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = primaryColor ?? colorScheme.primary;

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: _getTextColor(primary)),
          const SizedBox(width: 4),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null) ...[
              Text(
                label!,
                style: labelTextStyle ??
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
            ],
            Text(
              value,
              style: valueTextStyle ??
                  const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ],
    );

    switch (style) {
      case HighlightStyle.gradient:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: primary.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: _getTextColor(primary)),
            child: content,
          ),
        );

      case HighlightStyle.solid:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: _getTextColor(primary)),
            child: content,
          ),
        );

      case HighlightStyle.outlined:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DefaultTextStyle(
            style: TextStyle(color: primary),
            child: content,
          ),
        );
    }
  }

  Color _getTextColor(Color bgColor) {
    // Calcula si el texto debe ser claro u oscuro
    return bgColor.computeLuminance() > 0.5
        ? const Color(0xFF0F172A)  // Texto oscuro
        : const Color(0xFFF8FAFC);  // Texto claro
  }
}
